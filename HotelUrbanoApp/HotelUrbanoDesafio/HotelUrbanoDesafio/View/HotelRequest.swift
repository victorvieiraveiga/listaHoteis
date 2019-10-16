//
//  HotelRequest.swift
//  HotelUrbanoDesafio
//
//  Created by Victor Vieira on 14/10/19.
//  Copyright © 2019 Victor Vieira. All rights reserved.
//

import Foundation

enum HotelErro: Error {
    case noDataAvailable
    case canNoteProcessData
}

struct HotelRequest {
    let recursoURL: URL
    init () {
       let  recursoString = "https://www.hurb.com/search/api?q=buzios&page=1"
        
        guard let recursoURL = URL(string: recursoString) else {fatalError()}
        
        self.recursoURL = recursoURL
    }
    
    func getHoteis (completion: @escaping(Result<[HotelDetalhe],HotelErro>) -> Void) {
        let task = URLSession.shared.dataTask(with: recursoURL) {data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            //O Erro acontece aqui.
            do {
                let decoder = JSONDecoder()
                let hotelResult = try decoder.decode(HotelResults.self, from: jsonData)
                
                let hotelDetalhe = hotelResult.results
                completion(.success(hotelDetalhe))
            }catch {
                completion(.failure(.canNoteProcessData))
            }
        }
        task.resume()
    }
    
    

    
}

