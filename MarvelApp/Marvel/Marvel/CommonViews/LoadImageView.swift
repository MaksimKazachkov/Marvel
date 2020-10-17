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
    
    @State var fetcher: ImageFetcher
    
    var body: some View {
        ZStack {
            if let image = fetcher.image {
                Image(uiImage: image)
                    .resizable()
                    .renderingMode(.original)
            } else {
                Rectangle()
                    .foregroundColor(.gray)
            }
        }.onAppear(perform: {
            fetcher.downloadImage()
        })
    }
}

//struct LoadImage_Previews: PreviewProvider {
//    static var previews: some View {
//        LoadImage()
//    }
//}
