//
//  CramCategoryViewController.swift
//  AdaptiveCram
//
//  Created by 문은서 on 19/10/2019.
//

import UIKit

class CramCategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    // States
    let cellIdentifier: String = "OtherCramList"
    let aptitude_test: [String] = ["gsat", "hmat"]
    let korean_history: [String] = ["선사시대", "근현대사"]
    let driver_license: [String] = ["필기", "실기"]
    let computer_skills: [String] = ["2급", "1급"]
    var setNames: [SetName] = []
    
    // IBOutlets
    @IBOutlet weak var cramCategoryTableView: UITableView!
    @IBOutlet weak var cramCategorySearchBar: UISearchBar!
    
    // IBActions
   
    // View cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.cramCategoryTableView.dataSource = self
        self.cramCategoryTableView.delegate = self
        self.cramCategorySearchBar.delegate = self //서치바 관련 이벤트 처리
        self.cramCategorySearchBar.placeholder = "Input Category name" //힌트 등록
        
    }
    
    // API callers
    
    // Client updates
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return aptitude_test.count
        case 1:
            return korean_history.count
        /*case 2:
            return driver_license.count
        case 3:
            return computer_skills.count*/
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        
        if indexPath.section < 2 {
            
            let text: String = indexPath.section == 0 ? aptitude_test[indexPath.row] : korean_history[indexPath.row]
            cell.textLabel?.text = text
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section < 2 {
            return section == 0 ? "인적성" : "한국사"
        }
        
        return nil
    }
}
