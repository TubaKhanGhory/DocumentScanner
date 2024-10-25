//
//  OCRDataTableViewCell.swift
//  DocumentScanner
//
//  Created by TUBA on 25/10/2024.
//

import UIKit

class OCRDataTableViewCell: UITableViewCell {
    
    //@IBOutlets
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var value: UILabel!
    
    
    static func nib() -> UINib{
        return UINib(nibName: "OCRDataTableViewCell", bundle: .main)
    }
    
    static let identifier = "OCRDataTableViewCellID"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
