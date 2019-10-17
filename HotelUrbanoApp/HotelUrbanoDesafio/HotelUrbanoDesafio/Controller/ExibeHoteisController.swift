//
//  ExibeHoteisController.swift
//  HotelUrbanoDesafio
//
//  Created by Victor Vieira on 14/10/19.
//  Copyright © 2019 Victor Vieira. All rights reserved.
//

import UIKit
import SDWebImage


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

    // MARK: - Table View data source - Carrega Tabela - Insere Amenities
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
        
        // MARK: - Table View data source - Carrega Tabela - Insere Amenities
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
        
        // MARK: - Table View data source - Carrega Tabela - Define Estrelas
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
        
        // MARK: - Table View data source - Carrega Tabela - Exibe Foto Hotel
        //###### Exibe foto do hotel
        if let urlImagem = hoteis.image {
            let url = URL(string: urlImagem)
            DispatchQueue.main.async {
                cell.imgFotoHotel.sd_setImage(with: url) { (image, erro, cache, url) in
                    
                    if erro != nil {
                        //OBS Algumas urls estao classificadas como não seguras e estava dando erro.
                        //Foi necessario editar o arquivo plist e adicionar as tags:
                        //App Transport Security Settings: DIctionary
                        //    >> Allow Arbitrary Loads : Bool = YES
                        cell.imgFotoHotel.image = UIImage(named: "imagem_padrao.png")
                    }else {
                        print ("foto exibida")
                    }
                    
                }
            }
        }
        //###### Fim Exibe foto do hotel

        return cell
    }

    // MARK: - Função que chama rotina para consumir API
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
