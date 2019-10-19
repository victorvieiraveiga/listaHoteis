//
//  HotelUrbanoDesafioTestes.swift
//  HotelUrbanoDesafioTestes
//
//  Created by Victor Vieira on 19/10/19.
//  Copyright © 2019 Victor Vieira. All rights reserved.
//

import XCTest
@testable import HotelUrbanoDesafio

class HotelUrbanoDesafioTestes: XCTestCase {

    var exibeHotel : ExibeHoteisController!
    var requestHotel : HotelRequest!
    
    func testgetHoteis () {
        
        exibeHotel = ExibeHoteisController()
        
       // let bundle  = Bundle(for: HotelUrbanoDesafioTestes.self)
        
        let getHotel = exibeHotel.getHoteis()
        
        
        XCTAssert(exibeHotel.listaDeHoteis.count == 0)
        
        XCTAssertNotNil(exibeHotel.getHoteis())
        
        
    }
    
    func testfetchHoteis() {
        let fetchHotel = HotelRequest()
    
        
        XCTAssertNotNil(fetchHotel.fetchHoteis(sucess: { ([HotelDetalhe]) in}) { (error) in})
        
        
    }

    func testexibeHotelMapa() {
        let mapa = MapaController()
        
        //XCTAssertNil(mapa.exibeHotelMapa())
        
        XCTAssertNotNil(mapa.exibeHotelMapa())
    }
}
