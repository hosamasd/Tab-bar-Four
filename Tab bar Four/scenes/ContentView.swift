//
//  ContentView.swift
//  Tab bar Four
//
//  Created by hosam on 1/19/21.
//

import SwiftUI

struct ContentView: View {
    @State var selectedtab = "home"
    
    init() {
        
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        Home()
    }
}

struct ContentView_Prevsiews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
