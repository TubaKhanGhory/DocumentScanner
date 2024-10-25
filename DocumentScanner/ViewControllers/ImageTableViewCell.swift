//
//  ImageTableViewCell.swift
//  DocumentScanner
//
//  Created by TUBA on 25/10/2024.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var customImageView: UIImageView!
    
    
    static func nib() -> UINib{
        return UINib(nibName: "ImageTableViewCell", bundle: .main)
    }
    
    static let identifier = "ImageTableViewCellID"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customImageView.tintColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
