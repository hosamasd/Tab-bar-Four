//
//  Home.swift
//  Tab bar Four
//
//  Created by hosam on 1/19/21.
//

import SwiftUI

struct Home: View {
    
    @State var index = 0
    
    var body: some View {
       
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)){
            
            
            TabView(selection: $index){
                
//                PContentView()
                GContentView()
                    .ignoresSafeArea(.all, edges: .all)
                    .tag(0)
                   
                
//                FContentView()
                Color.purple
                    .ignoresSafeArea(.all, edges: .all)
                    .tag(1)
                
//                SHContentView()
                Color.purple
                    .ignoresSafeArea(.all, edges: .all)
                    .tag(2)
                
//                EWContentView()
////                Color.blue
////                    .ignoresSafeArea(.all, edges: .all)
//                    .tag("message")
            }
            
            
            CustomTabView(index: $index)
                
                
            }
        .ignoresSafeArea(.all, edges: .bottom)
        
    }
}

struct Home_Previvews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
