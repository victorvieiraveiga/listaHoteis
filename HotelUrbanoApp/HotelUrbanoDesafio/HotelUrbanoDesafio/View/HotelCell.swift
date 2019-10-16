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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
