//
//  RowTableViewCell.swift
//  TableRowImages
//
//  Created by Admin on 29/11/21.
//

import UIKit

class RowTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tableDisplayView: UIView!
    @IBOutlet weak var displayImg: UIImageView!
    @IBOutlet weak var displayTitleLabel: UILabel!
    @IBOutlet weak var displaySubTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableDisplayView = tableDisplayView.addShadowToView(viewObj:tableDisplayView)
    }
}

extension UIView{
    // adding shadow to the view for better visual effects
    func addShadowToView(viewObj:UIView) -> UIView{
        viewObj.layer.cornerRadius = 10
        viewObj.layer.shadowColor = UIColor.darkGray.cgColor
        viewObj.layer.masksToBounds = false
        viewObj.layer.shadowOffset = CGSize(width: 1, height: 1)
        viewObj.layer.shadowRadius = 5
        viewObj.layer.shadowOpacity = 0.4
        viewObj.layer.borderColor = UIColor.white.cgColor
        viewObj.layer.borderWidth = 0.1
        return viewObj
    }
}
