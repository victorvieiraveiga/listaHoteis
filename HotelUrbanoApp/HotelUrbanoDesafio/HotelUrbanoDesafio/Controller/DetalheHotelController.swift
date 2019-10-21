//
//  DetalheHotelController.swift
//  HotelUrbanoDesafio
//
//  Created by Victor Vieira on 17/10/19.
//  Copyright © 2019 Victor Vieira. All rights reserved.
//

import UIKit
import SDWebImage

class DetalheHotelController: UIViewController {

    @IBOutlet weak var labelNomeHotel: UILabel!
    @IBOutlet weak var imgFotoHotel: UIImageView!
    @IBOutlet weak var labelDescricao: UILabel!
    
    var listaDeHoteis : [HotelDetalhe] = []
    var index : Int?
    var section : Int?
    var results: [SectionTable: [HotelDetalhe]] = [:]
    var hotel: Any?
    var url: Any?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Se tenho conteudo no Array de hoteis(results) então preencho os campos da tela.
        if let tableSection = SectionTable(rawValue: self.section!), let hoteis = results[tableSection]?[self.index!] {
 
            labelNomeHotel.text = hoteis.name
            labelDescricao.text = hoteis.description
            
            //Exibe a foto do Hotel. Caso a categoria seja pacote exibe a logo do Hotel Urbano.
            if let categoria = hoteis.category {
                if categoria == "hospedagem" {
                    self.imgFotoHotel.image = UIImage(named: "hotel-urbano.png")
                } else {
                    let url = URL(string: hoteis.image!)
                    imgFotoHotel!.sd_setImage(with: url) { (image, erro, cache, url) in
                        if erro != nil
                        {
                            self.imgFotoHotel.image = UIImage(named: "imagem_padrao.png")
                        }
                    }
                }
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Segue para envia informacoes para a tela de mapa.
        if segue.identifier == "mapaSegue" {
            let destinoView = segue.destination as! MapaController
            let hoteis = listaDeHoteis[index!]
            let endereco = hoteis.address!.street! 
            
            destinoView.latitude = hoteis.address?.geoLocation?.lat
            destinoView.longitude = hoteis.address?.geoLocation?.lon
            destinoView.nomeHotel = hoteis.name 
            destinoView.endereco = endereco
        }
    }

}
