//
//  Hoteis.swift
//  HotelUrbanoDesafio
//
//  Created by Victor Vieira on 14/10/19.
//  Copyright © 2019 Victor Vieira. All rights reserved.
//

import Foundation
import MapKit




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
    var price : HotelPrice?
    var category: String?
}

class HotelAmenidades : Decodable {
    var name: String?
    var category: String?
}

class HotelAdress : Decodable {
    var city: String?
    var state: String?
    var street : String?
    var geoLocation : HotelGeoLocalizacao?
}

class HotelPrice : Decodable {
    var amountPerDay : Float?
}

class HotelGeoLocalizacao : Decodable {
    var lat : CLLocationDegrees?
    var lon : CLLocationDegrees?
}
