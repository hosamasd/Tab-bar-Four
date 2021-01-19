//
//  ContentView.swift
//  Gradient Picker
//
//  Created by hosam on 1/18/21.
//

import SwiftUI

struct GContentView: View {
    var body: some View {
        GHome()
            .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GContentView()
    }
}
