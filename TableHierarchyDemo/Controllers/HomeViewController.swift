//
//  HomeViewController.swift
//  TableHierarchyDemo
//
//  Created by Nirav Gondaliya on 2021-03-04.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var tblHome: UITableView!
    
    var homeDataArray : [SectionHeaderModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialSetup()
    }
    
    func initialSetup() {
        
        self.tblHome.delegate = self
        self.tblHome.dataSource = self
        
        self.tblHome.register(UINib(nibName: "CustomCell", bundle: nil),
                              forCellReuseIdentifier: CustomCell.reuseIdentifier)
        self.tblHome.register(UINib(nibName: "CustomHeaderView", bundle: nil),
                              forHeaderFooterViewReuseIdentifier: CustomHeaderView.reuseIdentifier)
    }
}

//MARK: - UIButtonActions
extension HomeViewController {
    
    @IBAction func didTapBtnAdd(_ sender: UIButton) {
        
        // Adding Header logic
        let sectionHeaderData = SectionHeaderModel(name: "Header \(homeDataArray.count + 1)", cells: nil)
        self.homeDataArray.append(sectionHeaderData)
        
        self.tblHome.reloadData()
        self.tblHome.scrollToRow(at: IndexPath(row: NSNotFound, section: self.homeDataArray.count - 1), at: .bottom, animated: true)
    }
}

//MARK: - UITableViewDelegate & UITableViewDataSource Methods
extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return homeDataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let cellDataCount = homeDataArray[section].cells?.count, cellDataCount > 0 {
            return cellDataCount
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellData = self.homeDataArray[indexPath.section].cells?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.reuseIdentifier) as! CustomCell
        
        cell.lblName.text = cellData?.name
        cell.lblCount.text = String(cellData?.numberOfItem ?? 0)
        cell.indexPath = indexPath
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomHeaderView.reuseIdentifier) as! CustomHeaderView
        
        headerView.lblTitle.text = homeDataArray[section].name
        headerView.section = section
        headerView.delegate = self
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

//MARK: - CustomHeaderViewDelegate Methods
extension HomeViewController : CustomHeaderViewDelegate {
    
    func didtapHeaderButton(section: Int) {
        
        //Adding Cell Logic
        var sectionData = self.homeDataArray[section]
        if let cellCount = sectionData.cells?.count, cellCount > 0 {
            
            let cellData = CustomCellModel(name: "Cell \(cellCount + 1)", numberOfItem: 1)
            sectionData.cells?.append(cellData)
            
        }else {
            sectionData.cells = [CustomCellModel(name: "Cell 1", numberOfItem: 1)]
        }
        
        self.homeDataArray[section].cells = sectionData.cells
        self.tblHome.reloadSections([section], with: .automatic)
        
    }
}

//MARK: - CustomCellDelegate Methods
extension HomeViewController : CustomCellDelegate {
    
    func didTapPlusButton(indexPath: IndexPath) {
        
        //Increament number in Cell Logic
        var sectionData = homeDataArray[indexPath.section]
        var cellData = sectionData.cells?[indexPath.row]
        
        cellData?.numberOfItem += 1
        sectionData.cells?[indexPath.row] = cellData!
        
        homeDataArray[indexPath.section] = sectionData
        self.tblHome.reloadRows(at: [indexPath], with: .automatic)
    }

    func didTapMinusButton(indexPath: IndexPath) {
        
        //Decreament number in Cell Logic
        var sectionData = homeDataArray[indexPath.section]
        var cellData = sectionData.cells?[indexPath.row]
        
        if cellData!.numberOfItem > 1 {

            cellData?.numberOfItem -= 1
            sectionData.cells?[indexPath.row] = cellData!
            homeDataArray[indexPath.section] = sectionData
            self.tblHome.reloadRows(at: [indexPath], with: .automatic)
            
        }else {
            
            print("Number of items is 1")
            //Logic for 0 will go here
        }
    }
}
