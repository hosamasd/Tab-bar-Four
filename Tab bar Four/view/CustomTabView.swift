//
//  TabView.swift
//  Nike hero and tab bar
//
//  Created by hosam on 1/18/21.
//

import SwiftUI

struct CustomTabView: View {
    
    @Binding var index:Int
    
    var body: some View {
        HStack(spacing: 0){
            
            Button {
                
                // animating..
                
                withAnimation{
                    
                    index = 0
                }
                
            } label: {
                
                HStack(spacing: 8){
                    
                    Image(systemName: "graduationcap.fill")
                        .foregroundColor(index == 0 ? .white : Color.black.opacity(0.35))
                        .padding(10)
                        .background(index == 0 ? Color.black : Color.clear)
                        .cornerRadius(8)
                    
                    Text(index == 0 ? "Gradient" : "")
                        .foregroundColor(.black)
                }
            }
            
            Spacer(minLength: 0)
            
            Button {
                
                // animating..
                
                withAnimation{
                    
                    index = 1
                }
                
            } label: {
                
                HStack(spacing: 8){
                    
                    Image(systemName: "photo.fill")
                        .foregroundColor(index == 1 ? .white : Color.black.opacity(0.35))
                        .padding(10)
                        .background(index == 1 ? Color.black : Color.clear)
                        .cornerRadius(8)
                    
                    Text(index == 1 ? "Splash" : "")
                        .foregroundColor(.black)
                }
            }
            
        }
        .padding(.top)
        .padding(.horizontal,25)
        .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 15 : UIApplication.shared.windows.first?.safeAreaInsets.bottom)
        
        .background(Color.white)
//        .clipShape(CShape(corners:[.topRight,.topLeft],width: 45))
        // since all edges are ignored...
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView(index: .constant(1))
    }
}
