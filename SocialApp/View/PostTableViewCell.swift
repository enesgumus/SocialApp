//
//  PostTableViewCell.swift
//  SocialApp
//
//  Created by Enes Gümüş on 22.10.2023.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var yorumTextfield: UILabel!
    @IBOutlet weak var PostImageView: UIImageView!
    @IBOutlet weak var kullaniciLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
