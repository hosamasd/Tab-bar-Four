//
//  Home.swift
//  Gradient Picker
//
//  Created by hosam on 1/18/21.
//

import SwiftUI

struct GHome: View {
    
    @State var show = false
//    @State var search = ""
//    @State var gradients : [Gradient] = []
    @State var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
//    @State var filtered : [Gradient] = []
    @StateObject var vm = GradientViewModel()
    var top = UIApplication.shared.windows.first?.safeAreaInsets.top
    
    
    var body: some View {
        
        VStack{
            
            HStack(spacing: 15){
                
                if show{
                    
                    TextField("Search Gradient", text: $vm.search)
                        // search Bar Functionality...
                        
                            .onChange(of: vm.search) { (value) in
                                
                                vm.makeSearchOperation()
                            
                            }
                    
                 
                    Button(action: {
                        
                        withAnimation(.easeOut){
                            
                            // clearing search...
                            vm.search = ""
                            // safe side...
                            vm.filtered = vm.gradients
                            show.toggle()
                        }
                        
                    }) {
                        
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                    }
                    
                
                }
                else{
                    
                    Text("Gradients")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                    
                    Spacer()
                 
                    Button(action: {
                        
                        withAnimation(.easeOut){
                            
                            show.toggle()
                        }
                        
                    }) {
                        
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                    }
                    
                    Button(action: {
                        
                        withAnimation(.easeOut){
                            
                            if columns.count == 1{
                                
                                columns.append(GridItem(.flexible(), spacing: 20))
                            }
                            else{
                                
                                columns.removeLast()
                            }
                        }
                        
                    }) {
                        
                        Image(systemName: columns.count == 1 ? "square.grid.2x2.fill" : "rectangle.grid.1x2.fill")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                
                
            }
            .padding(.top,top)
            .padding(.bottom,10)
            .padding(.horizontal)
            .zIndex(1)
            
            // Vstack Bug..
            
            if vm.gradients.isEmpty{
                
                // loading View...
                ProgressView()
                    .padding(.top,55)
                
                Spacer()
            }
            
            else{
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    
                    LazyVGrid(columns: columns,spacing: 20){
                        
                        // assigning name as ID...
                        
                        ForEach(vm.filtered,id: \.name){gradient in
                            
                            GradientView(columns: $columns, gradient: gradient, vm: vm)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
                .zIndex(0)
            }
            
            Spacer()
        }
        
    }
    
  
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        GHome()
            .preferredColorScheme(.dark)
    }
}
