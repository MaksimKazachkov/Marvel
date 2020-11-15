//
//  ContentView.swift
//  Marvel
//
//  Created by Maksim Kazachkov on 23.01.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import SwiftUI
import Redux
import MarvelDomain
import Core

struct CharactersRow: View {
    
    @EnvironmentObject var store: StoreWrapper<CharactersState>
    
    var body: some View {
        if store.state.characters.isEmpty, store.state.isLoading {
            Spinner(style: .medium)
                .onAppear {
                    store.dispatch(fetchCharacters)
                }
        } else {
            CharacterList(store: store)
        }
    }
    
}

struct CharacterList: View {
    
    @ObservedObject var store: StoreWrapper<CharactersState>
    
    var body: some View {
        GeometryReader { (bounds) in
            ScrollView(.horizontal, showsIndicators: true) {
                HStack(spacing: 20) {
                    ForEach(store.state.characters, id: \.id) { character in
                        GeometryReader { geometry in
                            CharacterItem(character: character)
                                .rotation3DEffect(
                                    getAngle(geometry: geometry, bounds: bounds),
                                    axis: (
                                        x: 0,
                                        y: 10,
                                        z: 0
                                    )
                                )
                        }
                        .frame(width: 300, height: 420)
                        .onAppear {
                            if store.state.characters.last == character {
                                store.dispatch(fetchCharacters)
                            }
                        }
                    }
                    if store.state.isLoading {
                        Spinner(style: .medium)
                    }
                }
                .padding(30)
                .padding(.bottom, 30)
            }
            .offset(y: -30)
        }
    }
    
    func getAngle(geometry: GeometryProxy, bounds: GeometryProxy) -> Angle {
        return Angle(degrees: Double(geometry.frame(in: .global).minX - 60) / -getAngleMultiplier(bounds: bounds))
    }
    
    func getAngleMultiplier(bounds: GeometryProxy) -> Double {
        if bounds.size.width > 500 {
            return 80
        } else {
            return 20
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CharactersRow()
                .environmentObject(charactersStore)
        }
    }
}
