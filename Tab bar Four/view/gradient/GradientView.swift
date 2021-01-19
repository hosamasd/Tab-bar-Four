//
//  GradientView.swift
//  Gradient Picker
//
//  Created by hosam on 1/18/21.
//

import SwiftUI

struct GradientView: View {
    
    @Binding var columns:[GridItem]
    var gradient:Gradient
    var vm:GradientViewModel
    
    
    var body: some View {
        VStack(spacing: 15){
            
            ZStack{
                
                LinearGradient(gradient: .init(colors: vm.HEXTORGB(colors: gradient.colors)), startPoint: .top, endPoint: .bottom)
                    .frame(height: 180)
                    .clipShape(CShape())
                    .cornerRadius(15)
                // context Menu...
                    .contentShape(CShape())
                    .contextMenu{
                        
                        Button(action: {
                            
                            // copying to copy Board..
                            
                            var colorCode = ""
                            
                            for color in gradient.colors{
                                
                                colorCode += color + "\n"
                            }
                            
                            UIPasteboard.general.string = colorCode
                            
                        }) {
                            
                            Text("Copy")
                        }
                    }
                
                Text(gradient.name)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(.horizontal)
            }
                
            if columns.count == 1{

                HStack(spacing: 15){

                    ForEach(gradient.colors,id: \.self){color in

                        Text(color)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}

