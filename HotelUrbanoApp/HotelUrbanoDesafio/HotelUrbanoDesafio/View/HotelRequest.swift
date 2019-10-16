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
        let task = URLSession.shared.dataTask(with: recursoURL) {(data, response, error )in
            
            guard let jsonData = data else {
                
                completion(.failure(.noDataAvailable))
                return
            }
            //O Erro acontece aqui.
            do {
                
                let decoder = JSONDecoder()
                let hotelResult = try decoder.decode(HotelResults.self, from: jsonData)
                
                let hotelDetalhe = hotelResult.results
                
                completion(.success(hotelDetalhe!))
                
            }catch {
                completion(.failure(.canNoteProcessData))
            }
        }
        task.resume()
    }
    
    
    static func fetchHoteis( sucess: @escaping ([HotelDetalhe]) -> Void, failure: @escaping (Error) -> Void) {
        let  recursoString = "https://www.hurb.com/search/api?q=buzios&page=1"
        
        if let url = URL(string: recursoString){
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request, completionHandler : { (data, response, error) in
                if let erro = error {
                    DispatchQueue.main.async {
                        failure(erro)
                    }
                }else{
                    if let data = data {
                        do {
                            let hotelResponse = try JSONDecoder().decode(HotelResults.self, from: data)
                            DispatchQueue.main.async {
                                sucess(hotelResponse.results!)
                            }
                        }catch {
                            DispatchQueue.main.async {
                                failure(error)
                            }
                        }
                    }
                }
            }).resume()
        }else{
            print("error url")
        }
    }
    
}

