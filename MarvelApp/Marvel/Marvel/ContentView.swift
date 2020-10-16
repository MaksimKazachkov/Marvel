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

struct ContentView: View {
    
    @EnvironmentObject var appStore: Store<AppState>
    
    var body: some View {
        switch appStore.state.characters {
        case .idle:
            Text("Idle").onTapGesture(perform: {
                appStore.dispatch(action: .characters(.loading))
            })
        case .loading:
            Text("Loading")
        case .loaded:
            Text("Loaded")
        case .failed:
            Text("Failed")
        }
    }
    
}

struct CharacterList: View {
    
    @Binding var props: [Character]
    
    var body: some View {
        List {
            ForEach(props) { row in
                Text(row.name ?? "No data")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environmentObject(appStore)
        }
    }
}
