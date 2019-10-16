//
//  ExibeHoteisController.swift
//  HotelUrbanoDesafio
//
//  Created by Victor Vieira on 14/10/19.
//  Copyright © 2019 Victor Vieira. All rights reserved.
//

import UIKit


class ExibeHoteisController: UITableViewController {
    
    //var listaDeHoteis = [HotelDetalhe]()
    
    
    var listaDeHoteis = [HotelDetalhe]() {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        guard let url  = URL(string: "https://www.hurb.com/search/api?q=buzios&page=1") else {return}
//
//        let session = URLSession.shared
//        session.dataTask(with: url) { (data, response, error) in
//            if let response = response {
//                print ("response")
//                print (response)
//            }
//
//            if let data = data {
//                print ("data")
//                print (data)
//
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
//                   // print ("json")
//                     //print (json)
//
//                    if let results = json["results"]  {
//
//                        let decoder = JSONDecoder()
//                        let resultado = try decoder.decode(HotelResults.self, from: data)
//                        //let hotelDetalhe  = resultado
//
//                        print ("############ results ###########")
//                        print (resultado.results)
//
//                        //self.listaDeHoteis = results
//
////                        print ("results")
////                        print (results)
//
//                    }
//
//                } catch  {
//                    print (error)
//                }
//
//
//            }
//        }.resume()
        
        
        let hotelRequest = HotelRequest()
        hotelRequest.getHoteis { [weak self] result in
            switch result {
            case .failure(let error) :
                print(error)
            case .success(let hoteis) :
                self?.listaDeHoteis = hoteis
            }

        }
        
//        if let url  = URL(string: "https://www.hurb.com/search/api?q=buzios&page=1") {
//            let task = URLSession.shared.dataTask(with: url) { (dados, requisicao, erro) in
//
//                if erro == nil {
//                    if let dadosRetorno = dados {
//                        do {
//                            if let objetoJson = try JSONSerialization.jsonObject(with: dadosRetorno, options: []) as? [String: Any] {
//
//                                 let decoder = JSONDecoder()
//
//                                let resultado = try decoder.decode(HotelResults.self, from: dadosRetorno)
//                                let hotelDetalhe  = resultado.results
//
//                                for h in hotelDetalhe {
//                                    print (h.name)
//                                }
                                
                                
//                                if let resultado = objetoJson["results"] as? [HotelDetalhe]  {
//
//                                    self.listaDeHoteis = resultado
//                                    print (resultado)
//
//                                    if let nome = resultado[0].name as? String {
//
//                                        print ("feio")
//                                        print (nome)
//                                        print ("feiooo")
//                                    }
//                                }
//                            }
//
//                        } catch  {
//                            print ("Erro!!!")
//                        }
//                    }
//                }
//                else {
//                    print ("Erro")
//                }
//
//            }
//            task.resume()
//        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listaDeHoteis.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let hoteis = listaDeHoteis[indexPath.row]

        cell.textLabel?.text = hoteis.name
        cell.detailTextLabel?.text = hoteis.url
        for ht in hoteis.amenities {
            let ameName = ht.name
        }
        
        return cell
    }




}
