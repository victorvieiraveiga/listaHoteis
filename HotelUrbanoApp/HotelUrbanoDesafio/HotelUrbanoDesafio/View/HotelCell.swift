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
    @IBOutlet weak var labelAmenidade2: UILabel!
    @IBOutlet weak var labelAmenidade3: UILabel!
    
    @IBOutlet weak var imgStar1: UIImageView!
    @IBOutlet weak var imgStar2: UIImageView!
    @IBOutlet weak var imgStar3: UIImageView!
    @IBOutlet weak var imgStar4: UIImageView!
    @IBOutlet weak var imgStar5: UIImageView!
    
    @IBOutlet weak var imgAmenities1: UIImageView!
    @IBOutlet weak var imgAmenities2: UIImageView!
    @IBOutlet weak var imgAmenities3: UIImageView!
    
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

}
