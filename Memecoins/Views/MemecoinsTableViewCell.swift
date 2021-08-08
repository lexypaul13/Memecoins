//
//  MemecoinsTableViewCell.swift
//  Memecoins
//
//  Created by Alex Paul on 5/23/21.
//

import UIKit

class MemecoinsTableViewCell: UITableViewCell {

    @IBOutlet weak var coinName: UILabel!
    @IBOutlet weak var tickerSymbol: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var memeprice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
