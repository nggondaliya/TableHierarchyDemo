//
//  CustomCell.swift
//  TableHierarchyDemo
//
//  Created by Nirav Gondaliya on 2021-03-04.
//

import UIKit

//MARK: - Protocol for Table Cell button action
protocol CustomCellDelegate {
    func didTapMinusButton(indexPath : IndexPath)
    func didTapPlusButton(indexPath : IndexPath)
}

class CustomCell: UITableViewCell {

    static let reuseIdentifier : String = String(describing: CustomCell.self)
    
    var indexPath : IndexPath?
    var delegate : CustomCellDelegate?
    
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

//MARK: - UIButtonActions
extension CustomCell {
    
    @IBAction func didTapMinusButton(_ sender: UIButton) {
        delegate?.didTapMinusButton(indexPath: indexPath!)
    }
    
    @IBAction func didTapPlusButton(_ sender: UIButton) {
        delegate?.didTapPlusButton(indexPath: indexPath!)
    }
}
