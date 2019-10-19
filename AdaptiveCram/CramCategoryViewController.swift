//
//  CramCategoryViewController.swift
//  AdaptiveCram
//
//  Created by 문은서 on 19/10/2019.
//

import UIKit

class CramCategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // States
    let cellIdentifier: String = "CramCategoryList"
    let aptitude_test: [String] = ["gsat", "hmat"]
    let korean_history: [String] = ["선사시대", "근현대사"]
    let driver_license: [String] = ["필기", "실기"]
    let computer_skills: [String] = ["2급", "1급"]
    var setNames: [SetName] = []
    
    // IBOutlets
    @IBOutlet weak var cramCategoryTableView: UITableView!
    
    // IBActions
   
    // View cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    // API callers
    
    // Client updates
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return aptitude_test.count
        case 1:
            return korean_history.count
        case 2:
            return driver_license.count
        case 3:
            return computer_skills.count
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
        
        switch section {
        case 0:
            return "적성검사"
        case 1:
            return "한국사"
        case 2:
            return "운전면허"
        case 3:
            return "컴활"
        default:
            return ""
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
