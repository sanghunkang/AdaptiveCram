//
//  ViewController.swift
//  AdaptiveCram
//
//  Created by Sanghun Kang on 25/08/2019.
//

import UIKit

struct Content: Codable {
    let _id: String?
    var _rev: String?
    var type: String?
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


class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    //MARK: Properties
    
    @IBOutlet var background: UIView!
    
    @IBOutlet weak var cramQuestion: UILabel!
    @IBOutlet weak var cramDescription: UILabel!
    
    @IBOutlet weak var feedbackUserAnswerLabel: UILabel!
    @IBOutlet weak var feedbackUserAnswerValue: UILabel!
    @IBOutlet weak var feedbackCorrectAnswerLabel: UILabel!
    @IBOutlet weak var feedbackCorrectAnswerValue: UILabel!
    
    
    var loadedContent: Content!
//    var loadedContent = Content(question: "sample question", answer: true, description: "sample description")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Handle the text field’s user input through delegate callbacks.
    }

    //MARK: UITextFieldDelegate
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
//        cramNameLabel.text = "Default Text"
    }
    
    @IBAction func handleClickLoadContent(_ sender: UIButton) {
        fetchGetContent()
    }
    
    @IBAction func handleAttempt(_ sender: UIButton) {
        
//        // create the alert
//        let alert = UIAlertController(title: "My Title", message: "This is my message.", preferredStyle: UIAlertController.Style.alert)
//
//        // add an action (button)
//        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//
//        // show the alert
//        self.present(alert, animated: true, completion: nil)
        
        // MORE ROBUST VALUE CHECK IS NEEDED
        feedbackUserAnswerValue.text = sender.title(for: .normal)
        if loadedContent.answer == true {
            feedbackCorrectAnswerValue.text = "True"
        } else {
            feedbackCorrectAnswerValue.text = "False"
        }
        
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
    
//    @IBAction func showAlertButtonTapped(_ sender: UIButton) {
//
//        // create the alert
//        let alert = UIAlertController(title: "My Title", message: "This is my message.", preferredStyle: UIAlertController.Style.alert)
//
//        // add an action (button)
//        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//
//        // show the alert
//        self.present(alert, animated: true, completion: nil)
//    }
    
    
    
    
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

        let components = URLComponents(string: "http://127.0.0.1:8080/updateContent")!
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
        let components = URLComponents(string: "http://127.0.0.1:8080/getSetNames")!
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
        var components = URLComponents(string: "http://127.0.0.1:8080/getContent")!
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
        feedbackCorrectAnswerLabel.text = "Correct Answer"
        print(hasAnsweredCorrect)
        if hasAnsweredCorrect == true {
            background.backgroundColor = UIColor.green
            feedbackUserAnswerValue.textColor = UIColor.green
            feedbackUserAnswerValue.text = "정답입니다!"
            feedbackCorrectAnswerValue.textColor = UIColor.green
        } else {
            background.backgroundColor = UIColor.red
            feedbackUserAnswerValue.text = "틀렸습니다!"
            feedbackCorrectAnswerValue.textColor = UIColor.red
        }
    }
    
    private func updateSolutionLabel() {
        cramDescription.text = loadedContent.solution
    }
}

