//
//  CharactersHomeView.swift
//  Marvel
//
//  Created by Maksim Kazachkov on 23.01.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import SwiftUI
import Combine
import Redux
import MarvelDomain
import Core

struct CharactersHomeView: View {
    
    @EnvironmentObject var store: StoreWrapper<CharactersState>
    
    private var actionCreators = ActionCreators.Characters()
    
    @State var isCarouselView = false
    
    var layoutButton: some View {
        Button(action: { self.isCarouselView.toggle() }) {
            Image(systemName: "text.justify")
                .rotationEffect(.degrees(isCarouselView ? 0 : 90))
                .imageScale(.large)
                .padding()
        }
    }
        
    var body: some View {
        NavigationView {
            VStack {
                if store.state.characters.isEmpty {
                    SpinnerView(style: .large)
                        .onAppear {
                            store.dispatch(actionCreators.fetch())
                        }
                } else {
                    if isCarouselView {
                        CharactersCarouselView(store: store)
                    } else {
                        CharactersGridView(store: store)
                    }
                }
            }.navigationBarItems(trailing: layoutButton)
        }
    }
    
}

struct CharactersHomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CharactersHomeView()
                .environmentObject(charactersStore)
        }
    }
}
