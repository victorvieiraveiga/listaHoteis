//
//  HotelCell.swift
//  HotelUrbanoDesafio
//
//  Created by Victor Vieira on 15/10/19.
//  Copyright © 2019 Victor Vieira. All rights reserved.
//

import UIKit

class HotelCell: UITableViewCell {

    
    @IBOutlet weak var labelNomeHotel: UILabel!
    @IBOutlet weak var labelPreco: UILabel!
    @IBOutlet weak var labelCidade: UILabel!
    @IBOutlet weak var labelEstado: UILabel!
    @IBOutlet weak var imgFotoHotel: UIImageView!
    
    @IBOutlet weak var labelAmenidade1: UILabel!

    @IBOutlet weak var imgStar1: UIImageView!
    @IBOutlet weak var imgStar2: UIImageView!
    @IBOutlet weak var imgStar3: UIImageView!
    @IBOutlet weak var imgStar4: UIImageView!
    @IBOutlet weak var imgStar5: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        escondeEstrelas()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func escondeEstrelas(){
        imgStar1.isHidden = true
        imgStar2.isHidden = true
        imgStar3.isHidden = true
        imgStar4.isHidden = true
        imgStar5.isHidden = true
    }
    
    func prepare (with hotel : HotelDetalhe) {
        
        //#Nome do Hotel ou Pacote
        labelNomeHotel.text = hotel.name
        
        //#Preço
        var precoString: String?
        if let preco = hotel.price?.amountPerDay {
            precoString = "Diária: R$" + String(format: "%.2f", preco)//Formata preço
            labelPreco.text = precoString
        }
        //#Endereco
        labelCidade.text = hotel.address?.city
        labelEstado.text = hotel.address?.state
        
        //#Foto
        if hotel.category == "hospedagem" {
             DispatchQueue.main.async {
                self.imgFotoHotel.image = UIImage(named: "hotel-urbano.png")
            }
        } else {
        
        if let urlImagem = hotel.image {
            let url = URL(string: urlImagem)
            DispatchQueue.main.async {
                self.imgFotoHotel.sd_setImage(with: url) { (image, erro, cache, url) in
                    
                    if erro != nil {
                        self.imgFotoHotel.image = UIImage(named: "imagem_padrao.png")
                    }else {
                        print ("foto exibida")
                    }
                }
            }
            }
        }
        
        //Amenities
        //Insere Amenities (Maximo tres)
         var cont : Int = 1
         var textoAmenities : String = ""
        
         for a in  hotel.amenities! {
             if cont < 4 {
                 if cont == 1 {
                     textoAmenities =   a.name!
                 }else {
                     textoAmenities =  (textoAmenities + ", " + a.name!)
                 }
              cont+=1
             }
         }
         labelAmenidade1.text = textoAmenities

        let stars = [self.imgStar1, self.imgStar2, self.imgStar3, self.imgStar4, self.imgStar5]
        
        //###### Define Numero de Estrelas
        //Rotina para apresentar o numero de estrelas de um hotel. Caso a categoria seja pacote,no exibe estrelas
        switch hotel.category  {
        case "hotel":
            for star in stars {
                star?.isHidden = true
            }
            if hotel.stars != nil {
                for i in 0...hotel.stars! - 1 {
                     stars[i]!.isHidden = false
                 }
             }
        case "pacote" :
            for star in stars {
                star?.isHidden = true
            }
        default :
              for star in stars {
                  star?.isHidden = true
              }
        }
        
    }

}
