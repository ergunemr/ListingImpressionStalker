//
//  CustomCollectionViewCell.swift
//  ListingImpressionDemoApp
//
//  Created by Emre on 22.03.2018.
//  Copyright © 2018 Emre. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    static let nibName = "CustomCollectionViewCell"
    static let reuseIdentifier = "customCell"
    
    @IBOutlet weak var cellBackground: UIView!
    @IBOutlet weak var indexLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellBackground.backgroundColor = .red
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
    }
}

extension CustomCollectionViewCell: ListingImpressionItem{
    func getUniqueId() -> String {
        return self.indexLabel.text!
    }
}
