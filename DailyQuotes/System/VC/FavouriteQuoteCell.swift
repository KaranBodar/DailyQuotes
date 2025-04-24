//
//  FavouriteQuoteCell.swift
//  DailyQuotes
//
//  Created by Karan Bodar on 24/04/25.
//

import UIKit

class FavouriteQuoteCell: UITableViewCell {

    // MARK: - IBOutlet -
    @IBOutlet weak var contentSaveLabel: UILabel!
    @IBOutlet weak var authrSaveLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
