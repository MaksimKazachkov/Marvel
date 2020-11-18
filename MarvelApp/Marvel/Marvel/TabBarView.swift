//
//  TabBarView.swift
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

struct TabBarView: View {
    
    @EnvironmentObject var store: StoreWrapper<CharactersState>
    
    @State var selection: Int = 0
    
    var body: some View {
        ZStack(
            alignment: Alignment(
                horizontal: .center,
                vertical: .bottom
            ),
            content: {
                TabView(
                    selection: $selection,
                    content:  {
                        CharactersHomeView().environmentObject(store)
                            .tabItem {
                                Text("Characters")
                                Image(systemName: "person.crop.square")
                            }
                    })
            })
    }
    
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
