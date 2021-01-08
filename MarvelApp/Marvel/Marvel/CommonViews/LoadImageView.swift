//
//  LoadImage.swift
//  Marvel
//
//  Created by Максим Казачков on 17.10.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import SwiftUI
import Combine
import Core
import MarvelDomain

struct LoadImageView: View {
    
    @ObservedObject var fetcher: ImageFetcher
    
    var body: some View {
        ZStack {
            switch fetcher.state {
            case .loaded(let image):
                Image(uiImage: image)
                    .resizable()
            case .loading:
                ZStack {
                    Color.gray
                    SpinnerView(
                        style: .medium,
                        color: .white
                    )
                }
            case .failed:
                ZStack {
                    Color.gray
                }
            }
        }
    }
}

struct LoadImageView_Previews: PreviewProvider {
    
    @State static var thumbnail = MarvelDomain.Image(
        path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
        extensionType: .jpg
    )
    
    static var previews: some View {
        LoadImageView(
            fetcher: ImageFetcher(
                thumbnail: thumbnail,
                aspectRation: .portrait(.uncanny)
            )
        )
    }
}
