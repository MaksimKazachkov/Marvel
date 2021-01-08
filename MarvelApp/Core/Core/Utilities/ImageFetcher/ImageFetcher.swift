//
//  ImageData.swift
//  Marvel
//
//  Created by Максим Казачков on 17.10.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import SwiftUI
import Combine
import MarvelDomain

public final class ImageFetcher: ObservableObject {
    
    @Published public var state: LoadState = .loading
    
    private static let imageCache = NSCache<AnyObject, AnyObject>()
    
    private let url: URL?
    
    private var cancelBag = Set<AnyCancellable>()
    
    private let aspectRation: AspectRationType
    
    public init(thumbnail: MarvelDomain.Image, aspectRation: AspectRationType) {
        self.aspectRation = aspectRation
        guard let url = URL(string: thumbnail.path) else {
            self.url = nil
            return
        }
        let imageVariant = ImageVariant(
            url: url,
            aspectRation: aspectRation
        )
        self.url = imageVariant.url.appendingPathExtension(thumbnail.extensionType.rawValue)
        downloadImage()
    }
    
    public func downloadImage() {
        guard let url = url else {
            state = .failed(Error.badURL)
            return
        }
        let urlString = url.absoluteString
        
        cachePublisher(forKey: urlString)
            .catch({ _ in self.diskPublisher(forKey: urlString) })
            .catch({ _ in self.networkPublisher(with: url) })
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .map { LoadState.loaded($0) }
            .catch { Just(LoadState.failed($0)) }
            .handleEvents(receiveOutput: { [weak self] (state) in
                if let image = state.image {
                    self?.save(image, forKey: urlString)
                }
            })
            .assign(to: \.state, on: self)
            .store(in: &cancelBag)
    }
    
    private func cachePublisher(forKey key: String) -> AnyPublisher<UIImage, Swift.Error> {
        return Future { (promise) in
            if let image = ImageFetcher.imageCache.object(forKey: key as AnyObject) as? UIImage {
                promise(.success(image))
            } else {
                promise(.failure(Error.noImageInCache))
            }
        }
        .eraseToAnyPublisher()
    }
    
    private func diskPublisher(forKey key: String) -> AnyPublisher<UIImage, Swift.Error> {
        return Future { [unowned self] (promise) in
            let decodedKey = self.decode(key)
            guard let filePath = self.filePath(forKey: decodedKey) else {
                promise(.failure(Error.badFilePath))
                return
            }
            guard let data = FileManager.default.contents(atPath: filePath.path) else {
                promise(.failure(Error.noImageOnDisk))
                return
            }
            guard let image = UIImage(data: data) else {
                promise(.failure(Error.incorrectData))
                return
            }
            promise(.success(image))
            
        }
        .eraseToAnyPublisher()
    }
    
    private func networkPublisher(with url: URL) -> AnyPublisher<UIImage, Swift.Error> {
        return Future { (promise) in
            do {
                let data = try Data(contentsOf: url)
                if let image = UIImage(data: data) {
                    promise(.success(image))
                } else {
                    promise(.failure(Error.incorrectData))
                }
            } catch {
                promise(.failure(error))
            }
            
        }
        .eraseToAnyPublisher()
    }
    
    private func save(_ image: UIImage, forKey key: String) {
        DispatchQueue.global(qos: .background).async { [ weak self] in
            ImageFetcher.imageCache.setObject(image, forKey: key as AnyObject)
            do {
                try self?.saveToDisk(image, forKey: key)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func saveToCache(_ image: UIImage, forKey key: String) {
        ImageFetcher.imageCache.setObject(image, forKey: key as AnyObject)
    }
    
    private func saveToDisk(_ image: UIImage, forKey key: String) throws {
        let decodedKey = decode(key)
        guard let filePath = filePath(forKey: decodedKey) else {
            return
        }
        guard !FileManager.default.fileExists(atPath: filePath.path) else {
            return
        }
        guard let data = image.jpegData(compressionQuality: 1) else {
            return
        }
        try data.write(to: filePath, options: .atomic)
    }
    
    private func documentsDirectory() -> URL? {
        return FileManager.default
            .urls(
                for: .documentDirectory,
                in: .userDomainMask
            )
            .first
    }
    
    private func directory(atPath path: String, rootDirectory: URL) -> URL? {
        let directory = rootDirectory.appendingPathComponent(path)
        if !FileManager.default.fileExists(atPath: directory.path) {
            do {
                try FileManager.default.createDirectory(
                    atPath: directory.path,
                    withIntermediateDirectories: true,
                    attributes: nil
                )
            } catch {
                print("Unable to create directory \(error.localizedDescription)")
                return nil
            }
        }
        return directory
    }
    
    private func imagesDirectory() -> URL? {
        guard let rootDirectory = documentsDirectory() else { return nil }
        guard let directory = directory(atPath: "images", rootDirectory: rootDirectory) else { return nil }
        return directory
    }
    
    private func charactersDirectory() -> URL? {
        guard let rootDirectory = imagesDirectory() else { return nil }
        guard let directory = directory(atPath: "characters", rootDirectory: rootDirectory) else { return nil }
        return directory
    }
    
    private func aspectRationDirectory() -> URL? {
        guard let rootDirectory = charactersDirectory() else { return nil }
        guard let directory = directory(atPath: "\(aspectRation.path)", rootDirectory: rootDirectory) else { return nil }
        return directory
    }
    
    private func filePath(forKey key: String) -> URL? {
        guard let directory = aspectRationDirectory() else { return nil }
        return directory.appendingPathComponent(key)
    }
    
    private func encode(_ key: String) -> String? {
        guard let data = Data(base64Encoded: key) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    func decode(_ key: String) -> String {
        return Data(key.utf8).base64EncodedString().appending(".jpg")
    }
    
}
