//
//  CramListViewController.swift
//  AdaptiveCram
//
//  Created by 문은서 on 13/10/2019.
//

import UIKit

class CramListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var cramListTableView: UITableView!
    let cellIdentifier: String = "CramList"
    
    let cpa: [String] = ["회계학", "경제학"]
    let toeic: [String] = ["700달성", "고난도어휘"]

    var dates: [Date] = []
    
    @IBAction func touchUpAddButton(_ sender: UIButton){
        dates.append(Date())
        self.cramListTableView.reloadData()
    }
    
    @IBOutlet var addListButton: UIButton!
    @IBOutlet var goCramButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return cpa.count
        case 1:
            return toeic.count
        case 2:
            return dates.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        
        if indexPath.section < 2 {
            
            let text: String = indexPath.section == 0 ? cpa[indexPath.row] : toeic[indexPath.row]
            cell.textLabel?.text = text
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section < 2 {
            return section == 0 ? "CPA" : "토익"
        }
        
        return nil
    }
}


