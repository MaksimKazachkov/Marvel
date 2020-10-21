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

enum ImageFetcherError: Swift.Error, CustomDebugStringConvertible {
    
    case incorrectData, badURL, noImageInCache
    
    var debugDescription: String {
        switch self {
        case .incorrectData:
            return "Data is currupt"
        case .badURL:
            return "Can not create url"
        case .noImageInCache:
            return "Image is not stored in cache"
        }
    }
    
}

final class ImageFetcher: ObservableObject {
    
    enum AspectRationType {
        
        case portrait(ImageType), standard(ImageType), landscape(ImageType), detail, fullSize
        
        var path: String {
            switch self {
            case .portrait(let value):
                return "portrait_\(value)"
            case .standard(let value):
                return "standard_\(value)"
            case .landscape(let value):
                return "landscape_\(value)"
            case .detail:
                return "detail"
            case .fullSize:
                return "fullSize"
            }
        }
        
    }
    
    enum LoadState {
        
        case loading, loaded(UIImage), failed(Swift.Error)
        
        var image: UIImage? {
            switch self {
            case .loaded(let value):
                return value
            case .loading,
                 .failed:
                return nil
            }
        }
        
    }
    
    enum ImageType: String {
        
        case small, medium, xLarge, fantastic, uncanny, incredible
        
    }
    
    struct ImageVariant {
        
        let url: URL
        
        public init(url: URL, aspectRation: AspectRationType) {
            self.url = url.appendingPathComponent(aspectRation.path)
        }
        
    }
    
    @Published var state: LoadState = .loading
    
    private static let imageCache = NSCache<AnyObject, AnyObject>()
    
    private let url: URL?
    
    private var cancelBag = Set<AnyCancellable>()
    
    init(thumbnail: MarvelDomain.Image, aspectRation: AspectRationType) {
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
            state = .failed(ImageFetcherError.badURL)
            return
        }
        let urlString = url.absoluteString
        
        fetchFromCache(forKey: urlString)
            .catch({ _ in self.networkPulisher(with: url) })
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
    
    private func networkPulisher(with url: URL) -> AnyPublisher<UIImage, Swift.Error> {
        return Future { (promise) in
            do {
                let data = try Data(contentsOf: url)
                if let image = UIImage(data: data) {
                    promise(.success(image))
                } else {
                    promise(.failure(ImageFetcherError.incorrectData))
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

    private func fetchFromCache(forKey key: String) -> AnyPublisher<UIImage, Swift.Error> {
        return Future { (promise) in
            if let image = ImageFetcher.imageCache.object(forKey: key as AnyObject) as? UIImage {
                promise(.success(image))
            } else {
                promise(.failure(ImageFetcherError.noImageInCache))
            }
        }
        .eraseToAnyPublisher()
    }
    
}
