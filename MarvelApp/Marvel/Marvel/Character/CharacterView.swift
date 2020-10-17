//
//  CharacterView.swift
//  Marvel
//
//  Created by Максим Казачков on 17.10.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import SwiftUI
import MarvelDomain

struct CharacterView: View {
    
    @Binding var character: Character
    
    var body: some View {
        VStack(alignment: .center, spacing: 10, content: {
        })
    }
}

struct CharacterView_Previews: PreviewProvider {
    
    @State static var character = Character(
        id: 1010870,
        name: "Ajaxis",
        description: "",
        modified: nil,
        resourceURI: URL(string: "http://gateway.marvel.com/v1/public/characters/1010870"),
        urls: nil,
        comics: nil,
        stories: nil,
        events: nil,
        series: nil
    )

    static var previews: some View {
        CharacterView(character: $character)
    }
}
