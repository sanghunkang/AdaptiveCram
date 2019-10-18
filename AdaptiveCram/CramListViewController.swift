//
//  CramListViewController.swift
//  AdaptiveCram
//
//  Created by 문은서 on 13/10/2019.
//

import UIKit

struct SetName: Codable {
    var set_name: String

    init(set_name: String) {
        self.set_name = set_name
    }
}

class CramListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // States
    let cellIdentifier: String = "CramList"
    let cpa: [String] = ["회계학", "경제학"]
    let toeic: [String] = ["700달성", "고난도어휘"]
    var setNames: [SetName] = []
    var dates: [Date] = []
    
    // IBOutlets
    @IBOutlet weak var cramListTableView: UITableView!
    @IBOutlet var addListButton: UIButton!
    @IBOutlet var goCramButton: UIButton!
    
    // IBActions
    @IBAction func touchUpAddButton(_ sender: UIButton){
        dates.append(Date())
        self.cramListTableView.reloadData()
    }
    
    // View cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchGetSetNames()
    }
    
    // API callers
    private func fetchGetSetNames() {
        let components = URLComponents(string: "http://173.193.112.127:31842/getSetNames")!
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                do {
                    print(String(data: data!, encoding: .utf8)!)
                    let decoder = JSONDecoder()
                    self?.setNames = try decoder.decode([SetName].self, from: data!)
                    print(self?.setNames as Any)
    
                } catch let error {
                    print(error)
                }
            }
        }
        print(setNames)
        task.resume();

    }
    
    
    // Client updates
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


