//
//  CharactersGridView.swift
//  Marvel
//
//  Created by Максим Казачков on 18.11.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import SwiftUI
import Combine
import Redux
import MarvelDomain
import Core

struct CharactersGridView: View {
    
    @ObservedObject var store: StoreWrapper<CharactersState>
    
    var actionCreators = ActionCreators.Characters()
    
    var columns = Array(
        repeating: GridItem(
            .flexible(),
            spacing: 20
        ),
        count: 2
    )
    
    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: columns,
                spacing: 20) {
                ForEach(
                    store.state.characters,
                    id: \.id) { character in
                    CharacterItemView(
                        character: character,
                        imageSize: CGSize(
                            width: (UIScreen.main.bounds.width - 50) / 2,
                            height: 180
                        ),
                        aspectRation: .standard(.large),
                        showName: false
                    )
                    .onAppear {
                        if store.state.characters.isLastItem(character) {
                            store.dispatch(actionCreators.fetch())
                        }
                    }
                }
                }.padding()
            if store.state.isLoading {
                SpinnerView(style: .medium)
            }
        }
    }
}

