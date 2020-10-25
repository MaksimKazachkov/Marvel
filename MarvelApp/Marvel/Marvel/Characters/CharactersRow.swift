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
    
    @EnvironmentObject var appStore: Store<AppState>
    @Environment(\.contentViewContainer) var container: CharactersViewContainer
    
    var body: some View {
        CharacterList(
            props: CharacterList.Props(
                characters: appStore.state.characters,
                canPaginate: appStore.state.canPaginate,
                performFetch: {
                    container.charactersInteractor.fetchCharacters()
                }
            )
        ).onAppear {
            container.charactersInteractor.fetchCharacters()
        }
    }
    
}

struct CharacterList: View {
    
    struct Props {
        
        var characters: [Character]
        var canPaginate: Bool
        var performFetch: (() -> Void)?
        
    }
    
    var props: Props
    
    var body: some View {
        GeometryReader { (bounds) in
            ScrollView(.horizontal, showsIndicators: true) {
                HStack(spacing: 20) {
                    ForEach(props.characters, id: \.id) { character in
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
                        .frame(width: 250, height: 320)
                    }
                    if props.canPaginate {
                        Spinner(style: .medium).onAppear(perform: props.performFetch)
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
                .environmentObject(appStore)
                .environment(\.contentViewContainer, resolver.resolve(CharactersViewContainer.self)!)
        }
    }
}
