//
//  GradientViewModel.swift
//  Gradient Picker
//
//  Created by hosam on 1/18/21.
//

import SwiftUI

class GradientViewModel: ObservableObject {
    
    @Published   var gradients : [Gradient] = []
    
    @Published   var filtered : [Gradient] = []
    @Published var search = ""
    
    init() {
        getColors()
    }
    
    func getColors(){
        
        // Loading JSON Data....
        
        let url = "https://raw.githubusercontent.com/ghosh/uiGradients/master/gradients.json"
        
        let seesion = URLSession(configuration: .default)
        
        seesion.dataTask(with: URL(string: url)!) { (data, _, _) in
            
            guard let jsonData = data else{return}
            
            do{
                
                // decoding Json...
                
                let colors = try JSONDecoder().decode([Gradient].self, from: jsonData)
                
                DispatchQueue.main.async {
                    self.gradients = colors
                    self.filtered = colors
                }
                
            }
            catch{
                
                print(error)
            }
        }
        .resume()
    }
    
    // Converting HEX Number To UICOlor.....
    
    func HEXTORGB(colors: [String])->[Color]{
        
        var colors1 : [Color] = []
        
        for color in colors{
            
            // removing #...
            
            var trimmed = color.trimmingCharacters(in: .whitespaces).uppercased()
            
            trimmed.remove(at: trimmed.startIndex)
            
            var hexValue : UInt64 = 0
            Scanner(string: trimmed).scanHexInt64(&hexValue)
            
            let r = CGFloat((hexValue & 0x00FF0000) >> 16) / 255
            let g = CGFloat((hexValue & 0x0000FF00) >> 8) / 255
            let b = CGFloat((hexValue & 0x000000FF)) / 255
            
            colors1.append(Color(UIColor(red: r, green: g, blue: b, alpha: 1.0)))
        }
        
        return colors1
    }
    
    func makeSearchOperation ()  {
        if search != ""{
            
            searchColor()
        }
        else{
            
            // clearing all search results..
            
            search = ""
            filtered = gradients
            
        }
    }
    
    func searchColor(){
        
        // filtering...
        
        let query = search.lowercased()
        
        // using bg thread to reduce Main ui Usage...
        
        DispatchQueue.global(qos: .background).async {
            
            let filter = self.gradients.filter { (gradient) -> Bool in
                
                if gradient.name.lowercased().contains(query){
                    
                    return true
                }
                else{
                    
                    return false
                }
            }
            
            // Refreshing View...
            DispatchQueue.main.async {
                
                // adding animation..
                
                withAnimation(.spring()){
                    
                    self.filtered = filter
                }
            }
        }
    }
}
