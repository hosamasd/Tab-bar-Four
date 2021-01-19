//
//  Home.swift
//  UnSplash Images
//
//  Created by hosam on 1/13/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct USHome: View {
    
    @State var expand = false
    @State var search = ""
    @StateObject var RandomImages = PhotoViewModel()
    @State var page = 1
    @State var isSearching = false
    
    //    var gridItems = Array(repeating:GridItem(.flexible()), count: 2)
    
    
    var body: some View {
        
        VStack(spacing: 0){
            
            HStack{
                
                // Hiding this view when search bar is expanded...
                
                if !self.expand{
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text("UnSplash")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("Beautiful,Free Photos")
                            .font(.caption)
                    }
                    .foregroundColor(.black)
                }
                
                
                Spacer(minLength: 0)
                
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .onTapGesture {
                        
                        withAnimation{
                            
                            self.expand = true
                        }
                    }
                
                // Displaying Textfield when search bar is expanded...
                
                if self.expand{
                    
                    TextField("Search...", text: self.$search)
                    
                    // Displaying Close Button....
                    
                    // Displaying search button when search txt is not empty...
                    
                    if self.search != ""{
                        
                        Button(action: {
                            
                            // Search Content....
                            // deleting all existing data and displaying search data...
                            
                            self.RandomImages.Images.removeAll()
                            
                            self.isSearching = true
                            
                            self.page = 1
                            
                            self.SearchData()
                            
                        }) {
                            
                            Text("Find")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                    }
                    
                    Button(action: {
                        
                        withAnimation{
                            
                            self.expand = false
                        }
                        
                        self.search = ""
                        
                        if self.isSearching{
                            
                            self.isSearching = false
                            self.RandomImages.Images.removeAll()
                            // updating home data....
                            self.RandomImages.updateData()
                        }
                        
                    }) {
                        
                        Image(systemName: "xmark")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.black)
                    }
                    .padding(.leading,10)
                    
                }
                
                
            }
            .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
            .padding()
            .background(Color.white)
            
            if self.RandomImages.Images.isEmpty{
                
                // Data is Loading...
                // or No Data...
                
                
                
                Spacer()
                
                if self.RandomImages.noresults{
                    
                    Text("No Results Found")
                }
                else{
                    
                    Indicator()
                }
                
                Spacer()
            }
            
            else{
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    //Collection View...
                    
                    VStack(spacing: 15){
                        
                            ForEach(self.RandomImages.Images,id: \.self){i in
                                
                               
                                LazyVGrid(columns:Array(repeating:GridItem(.flexible()), count: 2), spacing: 20) {
                                
                                ForEach(i){j in
                                    
                                    AnimatedImage(url: URL(string: j.urls["thumb"]!))
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        // padding on both sides 30 and spacing 20 = 50
                                        .frame(width: (UIScreen.main.bounds.width - 50) / 2, height: 200)
                                        .cornerRadius(15)
                                        .contextMenu {
                                            
                                            // Save Button
                                            
                                            Button(action: {
                                                
                                                // saving Image...
                                                
                                                // Image Quality...
                                                SDWebImageDownloader().downloadImage(with: URL(string: j.urls["small"]!)) { (image, _, _, _) in
                                                    
                                                    // For this we need permission...
                                                    
                                                    UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
                                                }
                                                
                                            }) {
                                                
                                                HStack{
                                                    
                                                    Text("Save")
                                                    
                                                    Spacer()
                                                    
                                                    Image(systemName: "square.and.arrow.down.fill")
                                                }
                                                .foregroundColor(.black)
                                            }
                                        }
                                }
                            }
                        }
                        
                        // Load More Button
                        
                        if !self.RandomImages.Images.isEmpty{
                            
                            if self.isSearching && self.search != ""{
                                
                                HStack{
                                    
                                    Text("Page \(self.page)")
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        
                                        // Updating Data...
                                        self.RandomImages.Images.removeAll()
                                        self.page += 1
                                        self.SearchData()
                                        
                                    }) {
                                        
                                        Text("Next")
                                            .fontWeight(.bold)
                                            .foregroundColor(.black)
                                    }
                                }
                                .padding(.horizontal,25)
                            }
                            
                            else{
                                
                                HStack{
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        
                                        // Updating Data...
                                        self.RandomImages.Images.removeAll()
                                        self.RandomImages.updateData()
                                        
                                    }) {
                                        
                                        Text("Next")
                                            .fontWeight(.bold)
                                            .foregroundColor(.black)
                                    }
                                }
                                .padding(.horizontal,25)
                            }
                        }
                    }
                    .padding(.top)
                }
            }
            
            
            
        }
        .background(Color.black.opacity(0.07).edgesIgnoringSafeArea(.all))
        .edgesIgnoringSafeArea(.top)
        
    }
    
    func SearchData(){

        let key = "pQlMXbXJ9Pb49k87EtTnI4Yloxo2yaKQTjcquvYzip4"
        // replacing spaces into %20 for query...
        let query = self.search.replacingOccurrences(of: " ", with: "%20")
        // updating page every time...
        let url = "https://api.unsplash.com/search/photos/?page=\(self.page)&query=\(query)&client_id=\(key)"
        hideKeyboard()
        self.RandomImages.SearchData(url: url)
    }
}

struct Home_Prevssiews: PreviewProvider {
    static var previews: some View {
        USHome()
    }
}
