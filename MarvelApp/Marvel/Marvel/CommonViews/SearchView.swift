//
//  SearchView.swift
//  Marvel
//
//  Created by Maksim on 08.01.2021.
//  Copyright © 2021 Maksim Kazachkov. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    
    let placeholder: String

    @State var query = ""

    var body: some View {
        HStack(spacing: 15){
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField(placeholder, text: $query)
        }
        .padding(.vertical,12)
        .padding(.horizontal)
        .background(Color.white)
        .clipShape(Capsule())
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(placeholder: "Search character")
    }
}
