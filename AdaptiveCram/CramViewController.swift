//
//  CramViewController.swift
//  AdaptiveCram
//
//  Created by 문은서 on 13/10/2019.

struct Content: Codable {
    let _id: String?
    var _rev: String?
    var type: String?

    // Field values which users must provide. Error will be raised when absent
    var content_id: String?
    var set_name: String
    var question: String
    var answer: Bool
    var solution: String

    // Automatically computed by service. Ordinary users wouldn't have access to manipulate these
    let rank: Int?
    var created_at: String?
    var last_served_at: String?
    var last_succeeded_at: String?
    var last_failed_at: String?
    var last_gaveup_at: String?
    var count_failed: Int?
    var count_succeeded: Int?
    var count_gaveup: Int?
}


import UIKit

class CramViewController: UIViewController {

    @IBOutlet var background: UIView!
   
    @IBOutlet weak var currentQustionNumberLabel: UILabel!
    @IBOutlet weak var totalQustionNumberLabel: UILabel!
    
    @IBOutlet weak var cramQuestion: UILabel!
    @IBOutlet weak var cramDescription: UILabel!
    
    @IBOutlet weak var nextCramButton: UIButton!

    var loadedContent: Content!
    //    var loadedContent = Content(question: "sample question", answer: true, description: "sample description")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func handleAttempt(_ sender: UIButton) {
        var hasAnsweredCorrect: Bool
        
        if sender.title(for: .normal) == "True" {
            hasAnsweredCorrect = (true == loadedContent.answer)
        } else if sender.title(for: .normal) == "False" {
            hasAnsweredCorrect = (false == loadedContent.answer)
        } else {
            hasAnsweredCorrect = false //???
        }
        fetchUpdateContent(hasAnsweredCorrect: hasAnsweredCorrect)
        updateFeedbackLabel(hasAnsweredCorrect: hasAnsweredCorrect)
        updateSolutionLabel()
    }
    
    @IBAction func handleTapNext(_ sender: UIButton) {
        fetchGetContent()
    }

    // API Callers
    private func fetchUpdateContent(hasAnsweredCorrect: Bool) {
        var answer_status = "undefined"
        if hasAnsweredCorrect == true {
            answer_status = "correct_answer"
        } else if hasAnsweredCorrect == false {
            answer_status = "correct_answer"
        }
        
        let json: [String: Any] = [
            "_id": loadedContent._id!,
            "set_name": loadedContent.set_name,
            "answer_status": answer_status,
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        let components = URLComponents(string: "http://173.193.112.127:31842/updateContent")!
        var request = URLRequest(url: components.url!)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            if error != nil {
                print(error!)
                return
            }
        }
        task.resume();
    }
    
    
    private func fetchGetSetNames() {
        let components = URLComponents(string: "http://173.193.112.127:31842/getSetNames")!
        //        components.queryItems = [
        //            URLQueryItem(name: "i", value: "1+2")
        //                ]
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            if error != nil {
                print(error!)
                return
            }
        }
        task.resume();
    }
    
    private func fetchGetContent() {
        var components = URLComponents(string: "http://173.193.112.127:31842/getContent")!
        components.queryItems = [
            URLQueryItem(name: "set_name", value: "commercial_law")
        ]
        var request = URLRequest(url: components.url!) //NSMutableURLRequest(url: url!);
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
                    self?.loadedContent = try decoder.decode(Content.self, from: data!)
                    print(self?.loadedContent.question as Any)
                
                    self?.cramQuestion.text = self?.loadedContent.question
                    self?.cramDescription.text = ""
                    
                } catch let error {
                    print(error)
                }
            }

        }
        
        task.resume();
    }
    
    // Client updates
    private func updateFeedbackLabel(hasAnsweredCorrect: Bool) {
//            feedbackCorrectAnswerLabel.text = "Correct Answer"
        print(hasAnsweredCorrect)
        if hasAnsweredCorrect == true {
            background.backgroundColor = UIColor.green
//                feedbackUserAnswerValue.textColor = UIColor.green
//                feedbackUserAnswerValue.text = "정답입니다!"
//                feedbackCorrectAnswerValue.textColor = UIColor.green
        } else {
            background.backgroundColor = UIColor.red
//                feedbackUserAnswerValue.text = "틀렸습니다!"
//                feedbackCorrectAnswerValue.textColor = UIColor.red
        }
    }
    
    private func updateSolutionLabel() {
        cramDescription.text = loadedContent.solution
    }
}
