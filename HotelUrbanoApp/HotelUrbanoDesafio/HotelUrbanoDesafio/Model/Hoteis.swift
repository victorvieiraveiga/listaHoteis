//
//  Hoteis.swift
//  HotelUrbanoDesafio
//
//  Created by Victor Vieira on 14/10/19.
//  Copyright © 2019 Victor Vieira. All rights reserved.
//

import Foundation




class HotelResults : Decodable {
   
    var results : [HotelDetalhe]?

}
class HotelDetalhe : Decodable {
    var name: String?
    var image: String?
    var url: String?
    var description : String?
    var stars: Int?
    var amenities : [HotelAmenidades]?
    var address: HotelAdress?
}

class HotelAmenidades : Decodable {
    var name: String?
    var category: String?
}

class HotelAdress : Decodable {
    var city: String?
    var state: String?
}
