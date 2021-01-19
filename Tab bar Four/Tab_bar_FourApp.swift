//
//  Tab_bar_FourApp.swift
//  Tab bar Four
//
//  Created by hosam on 1/19/21.
//

import SwiftUI

@main
struct Tab_bar_FourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        }
    }
}
