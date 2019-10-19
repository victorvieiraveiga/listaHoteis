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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let hoteis = listaDeHoteis[index!]
        
        labelNomeHotel.text = hoteis.name
        labelDescricao.text = hoteis.description
        
    
        if hoteis.category == "hospedagem" {
            
            self.imgFotoHotel.image = UIImage(named: "hotel-urbano.png")
            
        } else {
        
                let url = URL(string: hoteis.image!)
            
                imgFotoHotel.sd_setImage(with: url) { (image, erro, cache, url) in
                
                    if erro != nil
                    {
                        self.imgFotoHotel.image = UIImage(named: "imagem_padrao.png")
                    }
                }
            }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "mapaSegue" {
            let destinoView = segue.destination as! MapaController
            let hoteis = listaDeHoteis[index!]
            
            destinoView.latitude = hoteis.address?.geoLocation?.lat
            destinoView.longitude = hoteis.address?.geoLocation?.lon
            destinoView.nomeHotel = hoteis.name
        }
    }

}
