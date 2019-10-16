//
//  Hoteis.swift
//  HotelUrbanoDesafio
//
//  Created by Victor Vieira on 14/10/19.
//  Copyright © 2019 Victor Vieira. All rights reserved.
//

import Foundation




struct HotelResults : Decodable {
   
    var results : [HotelDetalhe]

}
struct HotelDetalhe : Decodable {
    var name: String
    var image: String
    var url: String
    var description : String
    var stars: Int
    var amenities : [HotelAmenidades]
    var adress: [HotelAdress]
}

struct HotelAmenidades : Decodable {
    var name: String
    var category: String
}

struct HotelAdress : Decodable {
    var city: String
    var state: String
}
