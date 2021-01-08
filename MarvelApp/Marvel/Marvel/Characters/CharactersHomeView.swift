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
        
    enum Mode {
        case grid, carousel
        
        mutating func toggle() {
            switch self {
            case .grid:
                self = .carousel
            case .carousel:
                self = .grid
            }
        }
    }
    
    @State var mode: Mode = .carousel
    
    var layoutButton: some View {
        Button(action: { self.mode.toggle() }) {
            Image(systemName: "text.justify")
                .rotationEffect(.degrees(mode == .carousel ? 0 : 90))
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
                            store.dispatch(ActionCreators.Characters.fetch())
                        }
                } else {
                    SearchView(placeholder: "Search")
                    switch mode {
                    case .carousel:
                        CharactersCarouselView(store: store)
                    case .grid:
                        CharactersGridView(store: store)
                    }
                }
            }
            .navigationBarItems(trailing: layoutButton)
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
