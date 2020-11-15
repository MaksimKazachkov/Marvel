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
    
    public init(thumbnail: MarvelDomain.Image, aspectRation: AspectRationType) {
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
            .catch({ _ in self.networkPublisher(with: url) })
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .map { LoadState.loaded($0) }
            .catch { Just(LoadState.failed($0)) }
            .handleEvents(receiveOutput: { [weak self] (state) in
                if let image = state.image {
                    self?.saveToCache(image, forKey: urlString)
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
    
    private func saveToCache(_ image: UIImage, forKey key: String) {
        DispatchQueue.global(qos: .background).async {
            ImageFetcher.imageCache.setObject(image, forKey: key as AnyObject)
        }
    }
    
}
