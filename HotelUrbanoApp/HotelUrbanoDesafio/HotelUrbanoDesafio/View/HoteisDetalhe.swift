//
//  HoteisModel.swift
//  HotelUrbanoDesafio
//
//  Created by Victor Vieira on 15/10/19.
//  Copyright © 2019 Victor Vieira. All rights reserved.
//

import UIKit


class HoteisResults : Decodable {
    var results : [HoteisDetalhe]
    
    init (results : [HoteisDetalhe]) {
        self.results = results
    }
}

class HoteisDetalhe : Decodable {

    var name: String
    var image: String
    var url: String
    var description : String
    var stars: Int
    
    init(name: String, image: String, url: String, description: String, stars: Int) {
        
        self.name = name
        self.image = image
        self.url = url
        self.description = description
        self.stars = stars
        
    }
    
}
