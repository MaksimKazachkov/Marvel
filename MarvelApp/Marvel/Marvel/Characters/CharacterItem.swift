//
//  CharacterView.swift
//  Marvel
//
//  Created by Максим Казачков on 17.10.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import SwiftUI
import MarvelDomain

struct CharacterItem: View {
    
    var character: Character
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            LoadImageView(fetcher: ImageFetcher(url: character.resourceURI!.appendingPathComponent("portrait_incredible.jpg")))
                .frame(width: 250, height: 300)
                .cornerRadius(5)
                .shadow(radius: 10)
            VStack(spacing: 4) {
                if let name = character.name {
                    Text(name)
                        .foregroundColor(.primary)
                        .font(.headline)
                }
                if let description = character.description {
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
            }
            .padding(.horizontal)
        }
    }
    
}

struct CharacterView_Previews: PreviewProvider {
    
    @State static var character = Character(
        id: 1010870,
        name: "Ajaxis",
        description: "Formerly known as Emil Blonsky, a spy of Soviet Yugoslavian origin working for the KGB, the Abomination gained his powers after receiving a dose of gamma radiation similar to that which transformed Bruce Banner into the incredible Hulk.",
        modified: nil,
        resourceURI: URL(string:"http://i.annihil.us/u/prod/marvel/i/mg/3/40/4bb4680432f73/portrait_incredible.jpg"),
        urls: nil,
        comics: nil,
        stories: nil,
        events: nil,
        series: nil
    )

    static var previews: some View {
        Group {
            CharacterItem(character: character)
        }
    }
}
