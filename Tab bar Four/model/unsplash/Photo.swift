//
//  Photo.swift
//  UnSplash Images
//
//  Created by hosam on 1/13/21.
//

import SwiftUI

struct Photo : Identifiable,Decodable,Hashable{
    
    var id : String
    var urls : [String : String]
}
