//
//  SpinnerView.swift
//  Marvel
//
//  Created by Максим Казачков on 25.10.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import SwiftUI

struct SpinnerView: UIViewRepresentable {
    
    let style: UIActivityIndicatorView.Style
    
    var color: UIColor? = nil

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(style: style)
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        return spinner
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        if let color = color {
            uiView.color = color
        }
    }
    
}
