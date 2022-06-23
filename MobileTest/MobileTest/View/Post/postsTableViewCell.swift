//
//  postsTableViewCell.swift
//  MobileTest
//
//  Created by Stephany Samaniego on 20/6/22.
//

import UIKit

class postsTableViewCell: UITableViewCell {

    @IBOutlet weak var noPostLabel: UILabel!
    @IBOutlet weak var titlePost: UILabel!
    @IBOutlet weak var favIcon: UIImageView!
    @IBOutlet weak var arrow: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
