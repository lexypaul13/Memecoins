//
//  WatchListTableViewCell.swift
//  Memecoins
//
//  Created by Alex Paul on 8/9/21.
//

import UIKit

class WatchListTableViewCell: UITableViewCell {

    @IBOutlet weak var cytpoName: UILabel!
    @IBOutlet weak var tickerSymbol: UILabel!
    @IBOutlet weak var cryptoAddess: UILabel!
    @IBOutlet weak var price: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
     }

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     }

}
