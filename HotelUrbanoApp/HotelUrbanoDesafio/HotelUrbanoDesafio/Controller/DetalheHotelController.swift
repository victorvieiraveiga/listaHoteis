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
        
        let url = URL(string: hoteis.image!)
        
        imgFotoHotel.sd_setImage(with: url) { (image, erro, cache, url) in
            if erro != nil {
                self.imgFotoHotel.image = UIImage(named: "imagem_padrao.png")
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
