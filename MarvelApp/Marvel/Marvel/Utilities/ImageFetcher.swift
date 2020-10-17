//
//  ImageData.swift
//  Marvel
//
//  Created by Максим Казачков on 17.10.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import SwiftUI
import Combine

final class ImageFetcher: ObservableObject {
    
    @Published var image: UIImage? = nil
    
    private static let imageCache = NSCache<AnyObject, AnyObject>()

    private let url: URL?
    
    init(url: URL?) {
        self.url = url
    }
    
    public func downloadImage() {
        guard let url = url else {
            image = nil
            return
        }
        let urlString = url.absoluteString
        
        if let imageFromCache = ImageFetcher.imageCache.object(forKey: urlString as AnyObject) as? UIImage {
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
                ImageFetcher.imageCache.setObject(image, forKey: urlString  as AnyObject)
                DispatchQueue.main.async { [weak self] in
                    self?.image = image
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}
