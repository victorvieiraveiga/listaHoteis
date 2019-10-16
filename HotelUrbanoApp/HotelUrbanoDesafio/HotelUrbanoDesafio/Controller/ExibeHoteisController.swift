//
//  ExibeHoteisController.swift
//  HotelUrbanoDesafio
//
//  Created by Victor Vieira on 14/10/19.
//  Copyright © 2019 Victor Vieira. All rights reserved.
//

import UIKit


class ExibeHoteisController: UITableViewController {
    
    var listaDeHoteis : [HotelDetalhe] = []
    var isError:Bool = false
    
//    var listaDeHoteis = [HotelDetalhe]() {
//        didSet{
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        

        getHoteis()
        

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
        let cell : HotelCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HotelCell

        let hoteis = listaDeHoteis[indexPath.row]
        
        var precoString: String?
        if let preco = hoteis.price?.current_price {
            precoString = "Diária: R$" + String(format: "%.2f", preco)
        }
        
        
        cell.labelNomeHotel.text = hoteis.name
        cell.labelPreco.text = precoString
        cell.labelCidade.text = hoteis.address?.city
        cell.labelEstado.text = hoteis.address?.state
        
        var cont : Int = 0
        while cont <= 3 {
            
            if cont == 0 {
                cell.labelAmenidade1.text = hoteis.amenities?[cont].name
            }
            if cont == 1 {
                cell.labelAmenidade2.text = hoteis.amenities?[cont].name
            }
            if cont == 2 {
                cell.labelAmenidade3.text = hoteis.amenities?[cont].name
            }
            
            cont = cont + 1
        }
        
        //cell.labelAmenidade1
        
        //cell.textLabel?.text = hoteis.name
        //cell.detailTextLabel?.text = hoteis.url
//        for ht in hoteis.amenities {
//            let ameName = ht.name
//        }
        
        return cell
    }


    func getHoteis(){
        HotelRequest.fetchHoteis( sucess: { (hoteis) in
            self.isError = false
            self.listaDeHoteis.append(contentsOf: hoteis)
            self.tableView.reloadData()
        }) { (error) in
            self.isError = true
            self.tableView.reloadData()
            print(error)
        }
    }
    
    func defineEstrelas (numStar: Int) {
        
    }

}
