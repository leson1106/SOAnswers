//
//  PaymentAmountCell.swift
//  MyAnswer
//
//  Created by Son Le on 11/11/2023.
//

import UIKit

class PaymentAmountCell: UITableViewCell {

    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var amount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        type.superview?.layer.borderColor = UIColor.lightGray.cgColor
        type.superview?.layer.borderWidth = 0.5
        type.superview?.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        if selected {
            type.superview?.backgroundColor = .blue
        } else {
            type.superview?.backgroundColor = .white
        }
    }
    
    func toggleSelected(_ isSelected: Bool) {
        type.superview?.backgroundColor = isSelected ? .blue : .white
    }
}
