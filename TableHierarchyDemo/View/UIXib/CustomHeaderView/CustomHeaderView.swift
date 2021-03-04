//
//  CustomHeaderView.swift
//  TableHierarchyDemo
//
//  Created by Nirav Gondaliya on 2021-03-04.
//

import UIKit

//MARK: - Protocol for Table header button action
protocol CustomHeaderViewDelegate {
    func didtapHeaderButton(section : Int)
}

class CustomHeaderView: UITableViewHeaderFooterView {

    static let reuseIdentifier : String = String(describing: CustomCell.self)
    
    var delegate : CustomHeaderViewDelegate?
    var section : Int?

    @IBOutlet var lblTitle: UILabel!
    
}

//MARK: - UIButtonActions
extension CustomHeaderView {
    
    @IBAction func didTapHeaderButton(sender : UIButton) {
        delegate?.didtapHeaderButton(section: section ?? 0)
    }
}
