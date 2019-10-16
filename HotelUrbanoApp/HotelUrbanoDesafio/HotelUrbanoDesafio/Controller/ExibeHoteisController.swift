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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //chama api hoteis
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
        
        
        //######### Insere Amenities (Maximo tres)
        var cont : Int = 1
        while cont < hoteis.amenities!.count  {
            
            if cont == 1 {
                if let amenities = hoteis.amenities?[cont].name {
                    cell.labelAmenidade1.text = amenities
                }
            }
            if cont == 2 {
                if let amenities = hoteis.amenities?[cont].name {
                    cell.labelAmenidade2.text = hoteis.amenities?[cont].name
                }
            }
            if cont == 3 {
                if let amenities = hoteis.amenities?[cont].name {
                    cell.labelAmenidade3.text = hoteis.amenities?[cont].name
                }
            }
            cont = cont + 1
        }//######### Fim Amenidades
        
        //###### Define Numero de Estrelas
        let stars = hoteis.stars
        switch stars {
        case 1:
            cell.imgStar1.isHidden = false
            cell.imgStar2.isHidden = true
            cell.imgStar3.isHidden = true
            cell.imgStar4.isHidden = true
            cell.imgStar5.isHidden = true
        case 2:
            cell.imgStar1.isHidden = false
            cell.imgStar2.isHidden = false
            cell.imgStar3.isHidden = true
            cell.imgStar4.isHidden = true
            cell.imgStar5.isHidden = true
        case 3:
            cell.imgStar1.isHidden = false
            cell.imgStar2.isHidden = false
            cell.imgStar3.isHidden = false
            cell.imgStar4.isHidden = true
            cell.imgStar5.isHidden = true
        case 4:
            cell.imgStar1.isHidden = false
            cell.imgStar2.isHidden = false
            cell.imgStar3.isHidden = false
            cell.imgStar4.isHidden = false
            cell.imgStar5.isHidden = true
        case 5:
            cell.imgStar1.isHidden = false
            cell.imgStar2.isHidden = false
            cell.imgStar3.isHidden = false
            cell.imgStar4.isHidden = false
            cell.imgStar5.isHidden = false
        default:
            cell.imgStar1.isHidden = false
            cell.imgStar2.isHidden = false
            cell.imgStar3.isHidden = false
        }//##### Fim Numero de Estrelas
        
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
}
