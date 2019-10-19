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
    //let appDelegate = UIApplication.shared.delegate as! AppDelegate     // 앱 델리게이트 참조 정보를 가져옴

    let cellIdentifier: String = "CramList"
    let cpa: [String] = ["회계학", "경제학"]
    let toeic: [String] = ["700달성", "고난도어휘"]
    var setNames: [SetName] = []
    
    // IBOutlets
    @IBOutlet weak var cramListTableView: UITableView!
    @IBOutlet var addListButton: UIButton!
    @IBOutlet var goCramButton: UIButton!
    
    // IBActions
    
    // View cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchGetSetNames()
    }
    
    override func viewWillAppear(_ animated: Bool) {//뷰가 화면에 출력되면 호출
        
        //self.cramListTableView.reloadData()//테이블 데이터 리로드
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
        
        /*return self.appDelegate.CramQuestionList.count*/
        switch section {
        case 0:
            return cpa.count
        case 1:
            return toeic.count
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


