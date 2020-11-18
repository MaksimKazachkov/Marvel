//
//  CharacterItemView.swift
//  Marvel
//
//  Created by Максим Казачков on 17.10.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import SwiftUI
import MarvelDomain
import Core

struct CharacterItemView: View {
    
    var character: Character
    
    var imageSize: CGSize
    
    var aspectRation: ImageFetcher.AspectRationType
    
    var showName: Bool = true
    
    var body: some View {
        VStack(
            alignment: .center,
            spacing: 10
        ) {
            if let thumbnail = character.thumbnail {
                LoadImageView(
                    fetcher: ImageFetcher(
                        thumbnail: thumbnail,
                        aspectRation: aspectRation
                    )
                )
                .cornerRadius(5)
                .shadow(radius: 10)
                .frame(
                    width: imageSize.width,
                    height: imageSize.height
                )
                .aspectRatio(contentMode: .fit)
            } else {
                Color.gray
                    .cornerRadius(5)
                    .shadow(radius: 10)
                    .frame(
                        width: imageSize.width,
                        height: imageSize.height
                    )
            }
            if showName, let name = character.name {
                Text(name)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primary)
                    .font(.headline)
            }
        }
    }
    
}

struct CharacterItemView_Previews: PreviewProvider {
    
    @State static var character = Character(
        id: 1010870,
        name: "Ajaxis",
        description: "Formerly known as Emil Blonsky, a spy of Soviet Yugoslavian origin working for the KGB, the Abomination gained his powers after receiving a dose of gamma radiation similar to that which transformed Bruce Banner into the incredible Hulk.",
        modified: nil,
        resourceURI: nil,
        urls: nil,
        thumbnail: MarvelDomain.Image.init(
            path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
            extensionType: .jpg),
        comics: nil,
        stories: nil,
        events: nil,
        series: nil
    )
    
    static var previews: some View {
        CharacterItemView(
            character: character,
            imageSize: CGSize(
                width: 300,
                height: 450
            ),
            aspectRation: .portrait(.uncanny)
        )
    }
}
