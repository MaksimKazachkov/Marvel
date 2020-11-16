//
//  HomeView.swift
//  Marvel
//
//  Created by Maksim Kazachkov on 23.01.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import SwiftUI
import Redux
import MarvelDomain
import Core

struct HomeView: View {
    
    @EnvironmentObject var store: StoreWrapper<CharactersState>
    
    var body: some View {
        if store.state.characters.isEmpty {
            SpinnerView(style: .large)
                .onAppear {
                    store.dispatch(fetchCharacters)
                }
        } else {
            CharactersCarouselView(store: store)
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView()
                .environmentObject(charactersStore)
        }
    }
}
