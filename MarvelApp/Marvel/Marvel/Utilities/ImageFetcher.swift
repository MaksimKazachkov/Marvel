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

final class ImageFetcher: ObservableObject {
    
    enum AspectRationType {
        
        case portrait(ImageType), standard(ImageType), landscape(ImageType), detail, fullSize
        
    }
    
    enum ImageType: String {
        
        case small, medium, xLarge, fantastic, uncanny, incredible
        
    }
    
    struct ImageVariant {
        
        let url: URL
        
        public init(url: URL, aspectRation: AspectRationType) {
            var url = url
            switch aspectRation {
            case .portrait(let type):
                url.appendPathComponent("portrait_\(type)")
            case .standard(let type):
                url.appendPathComponent("standard_\(type)")
            case .landscape(let type):
                url.appendPathComponent("landscape_\(type)")
            case .detail:
                url.appendPathComponent("detail")
            case .fullSize:
                url.appendPathComponent("fullSize")
            }
            self.url = url
        }
        
    }
      
    @Published var image: UIImage? = nil
    
    private static let imageCache = NSCache<AnyObject, AnyObject>()

    private let url: URL?
    
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
    }
    
    public func downloadImage() {
        guard let url = url else {
            image = nil
            return
        }
        let urlString = url.absoluteString
        
        if let imageFromCache = fetchFromCache(forKey: urlString) {
            self.image = imageFromCache
            return
        }
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            do {
                let data = try Data(contentsOf: url)
                guard let image = UIImage(data: data) else {
                    return
                }
                self.save(image, forKey: urlString)
                DispatchQueue.main.async { [weak self] in
                    self?.image = image
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchFromCache(forKey key: String) -> UIImage? {
        return ImageFetcher.imageCache.object(forKey: key as AnyObject) as? UIImage
    }
    
    private func save(_ image: UIImage, forKey key: String) {
        ImageFetcher.imageCache.setObject(image, forKey: key as AnyObject)
    }
    
}
