//
//  SearchTableViewCell.swift
//  manageImages
//
//  Created by Jonald Ramos on 2/11/17.
//  Copyright © 2017 Pratik Anilkumar Parmar. All rights reserved.
//it's searching page Table View 

import UIKit

class SearchTableViewCell: UITableViewCell {


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//takiing all cell data in page 
    @IBOutlet weak var imgView: UIImageView!    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
/* func congigureCell(text: String) {
        
        nameLable.text = text
    }*/
    
}
