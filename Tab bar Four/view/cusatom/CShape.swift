//
//  CShape.swift
//  Gradient Picker
//
//  Created by hosam on 1/18/21.
//

import SwiftUI


struct CShape : Shape {
    
    var corners:UIRectCorner = [.topRight,.bottomLeft]
    
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners:corners , cornerRadii: CGSize(width: 55, height: 55))
        
        return Path(path.cgPath)
    }
}
