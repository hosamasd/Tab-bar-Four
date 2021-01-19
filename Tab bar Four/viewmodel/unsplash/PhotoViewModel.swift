//
//  PhotoViewModel.swift
//  UnSplash Images
//
//  Created by hosam on 1/13/21.
//

import SwiftUI

class PhotoViewModel: ObservableObject {
  
    // Going to Create Collection View.....
    // Thats Why 2d Array...
    @Published var Images : [[Photo]] = []
    @Published var noresults = false
    
    
    init() {
        
        // Intial Data...
        updateData()
    }
    
    
    
    func updateData(){
        
        self.noresults = false
        
        let key = "pQlMXbXJ9Pb49k87EtTnI4Yloxo2yaKQTjcquvYzip4"
        let url = "https://api.unsplash.com/photos/random/?count=30&client_id=\(key)"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { (data, _, err) in
            
            if err != nil{
                
                print((err?.localizedDescription)!)
                return
            }
            
            // JSON decoding...
            
            do{
                
                let json = try JSONDecoder().decode([Photo].self, from: data!)
                
                
                // going to create collection view each row has two views...
                
                for i in stride(from: 0, to: json.count, by: 2){
                    
                    var ArrayData : [Photo] = []
                    
                    for j in i..<i+2{
                        
                        // Index out bound ....
                        
                        if j < json.count{
                            
                        
                            ArrayData.append(json[j])
                        }
                    }
                    
                    DispatchQueue.main.async {
                        
                        self.Images.append(ArrayData)
                    }
                }
            }
            catch{
                
                print(error.localizedDescription)
            }
            
            
        }
        .resume()
    }

    func Search()  {
        
//        let key = "pQlMXbXJ9Pb49k87EtTnI4Yloxo2yaKQTjcquvYzip4"
//        // replacing spaces into %20 for query...
//        let query = self.search.replacingOccurrences(of: " ", with: "%20")
//        // updating page every time...
//        let url = "https://api.unsplash.com/search/photos/?page=\(self.page)&query=\(query)&client_id=\(key)"
////        hideKeyboard()
//        self.SearchData(url: url)
    }
    
    func SearchData(url: String){
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { (data, _, err) in
            
            if err != nil{
                
                print((err?.localizedDescription)!)
                return
            }
            
            // JSON decoding...
            
            do{
                
                let json = try JSONDecoder().decode(SearchPhoto.self, from: data!)
                
                
                if json.results.isEmpty{
                    
                    self.noresults = true
                }
                else{
                    
                    self.noresults = false
                }
                
                // going to create collection view each row has two views...
                
                for i in stride(from: 0, to: json.results.count, by: 2){
                    
                    var ArrayData : [Photo] = []
                    
                    for j in i..<i+2{
                        
                        // Index out bound ....
                        
                        if j < json.results.count{
                            
                        
                            ArrayData.append(json.results[j])
                        }
                    }
                    
                    DispatchQueue.main.async {
                        
                        self.Images.append(ArrayData)
                    }
                }
            }
            catch{
                
                print(error.localizedDescription)
            }
            
            
        }
        .resume()
    }
    
}
