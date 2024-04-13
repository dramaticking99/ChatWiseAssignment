//
//  ProductCell.swift
//  ChatWiseAssignment
//
//  Created by Chetan Sanwariya on 11/04/24.
//

import UIKit

class ProductCell: UITableViewCell {

    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        productDescriptionLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
