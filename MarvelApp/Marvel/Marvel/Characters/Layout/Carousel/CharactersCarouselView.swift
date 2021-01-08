//
//  CharactersCarouselView.swift
//  Marvel
//
//  Created by Максим Казачков on 15.11.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import SwiftUI
import Combine
import Redux
import MarvelDomain
import Core

struct CharactersCarouselView: View {
    
    @ObservedObject var store: StoreWrapper<CharactersState>
    
    var body: some View {
        GeometryReader { (bounds) in
            ScrollView(.horizontal, showsIndicators: true) {
                LazyHStack(spacing: 5) {
                    ForEach(store.state.characters, id: \.id) { character in
                        GeometryReader { geometry in
                            VStack {
                                Spacer()
                                CharacterView(
                                    character: character,
                                    imageSize: CGSize(
                                        width: 300,
                                        height: 450
                                    ),
                                    aspectRation: .portrait(.uncanny)
                                )
                                .onAppear {
                                    if store.state.characters.isLastItem(character) {
                                        store.dispatch(ActionCreators.Characters.fetch())
                                    }
                                }
                                .rotation3DEffect(
                                    getAngle(geometry: geometry, bounds: bounds),
                                    axis: (
                                        x: 0,
                                        y: 10,
                                        z: 0
                                    )
                                )
                                Spacer()
                            }
                        }
                    }
                    .frame(width: 300)
                    if store.state.isLoading {
                        SpinnerView(style: .medium)
                    }
                }
                .padding(30)
            }
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

struct CharactersCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersCarouselView(store: charactersStore)
            .onAppear {
                try! AssemblyFactory().applyAssemblies()
                charactersStore.dispatch(ActionCreators.Characters.fetch())
            }
    }
}
