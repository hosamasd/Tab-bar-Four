//
//  Indicator.swift
//  UnSplash Images
//
//  Created by hosam on 1/13/21.
//

import SwiftUI

struct Indicator : UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        
        let view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        return view
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        
        
    }
}
