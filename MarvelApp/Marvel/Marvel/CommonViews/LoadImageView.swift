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
