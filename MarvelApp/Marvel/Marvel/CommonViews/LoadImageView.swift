//
//  LoadImage.swift
//  Marvel
//
//  Created by Максим Казачков on 17.10.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import SwiftUI
import Combine

struct LoadImageView: View {
    
    @ObservedObject var fetcher: ImageFetcher
    
    var body: some View {
        ZStack {
            switch fetcher.state {
            case .loaded(let image):
                Image(uiImage: image)
                    .resizable()
                    .renderingMode(.original)
            case .loading:
                Text("Loading")
            case .failed(let error):
                Text("Failed with error: \(error.localizedDescription)")
            }
        }
    }
}

//struct LoadImage_Previews: PreviewProvider {
//    static var previews: some View {
//        LoadImage()
//    }
//}
