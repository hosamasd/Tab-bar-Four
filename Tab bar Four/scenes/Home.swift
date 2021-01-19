//
//  Home.swift
//  Tab bar Four
//
//  Created by hosam on 1/19/21.
//

import SwiftUI

struct Home: View {
    
    @State var index = 0
    @State var show = true
    
    var body: some View {
       
        
        ZStack {
            
            VStack(spacing: 0){
                
                TabView(selection: $index){
                    
                    GContentView()
//                        .ignoresSafeArea(.all, edges: .all)
                        .tag(0)
                       
                    
                    USContentView()
                        .ignoresSafeArea(.all, edges: .all)
                        .tag(1)
                }
                
                CustomTabView(index: $index)
                
            }
            
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color.black.opacity(0.08).edgesIgnoringSafeArea(.all))
        
//
    }
}

struct Home_Previvews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
