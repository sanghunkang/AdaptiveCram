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
    let question: String
    let answer: Bool
    let description: String
    let rank: Int?
    let last_answered_wrong: String?
}

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var cramNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    var loadedContent: Content!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self

    }

    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        cramNameLabel.text = nameTextField.text
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func trueButton(_ sender: Any) {
    }
    
    
    @IBAction func falseBUtton(_ sender: Any) {
    }
    
    //MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        cramNameLabel.text = "Default Text"
    }
    
    @IBAction func setDefaultLabelText2(_ sender: UIButton) {

        var components = URLComponents(string: "http://127.0.0.1:8000/getContent")!

        components.queryItems = [
//            URLQueryItem(name: "i", value: "1+2")
        ]

//        let params = String(params);
        var request = URLRequest(url: components.url!) //NSMutableURLRequest(url: url!);
        request.httpMethod = "GET"
//        request.HTTPBody = params.dataUsingEncoding(NSUTF8StringEncoding)

        let task = URLSession.shared.dataTask(with: request) {[weak self] data, response, error in

            if error != nil {
                print(error!)
                return
            }

            
            DispatchQueue.main.async {
                
                do {
                    print(String(data: data!, encoding: .utf8)!)
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(Content.self, from: data!)
//                    print(data.last_answered_wrong!)
                    self?.loadedContent = try decoder.decode(Content.self, from: data!)
                    print(self?.loadedContent.question)
                
                    self?.cramNameLabel.text = data.question
                } catch let error {
                    print(error)
                }
            }

        }
        
        task.resume();
        
    }
    
    // TODO : I THINK THEY MUST BE WRAPPED AND TRIGGERED BY A SINGLE FUNCTION
    @IBAction func setDescriptionText(_ sender: UIButton) {
        
    }
    
    @IBAction func setAnswerText(_ sender: UIButton) {
        
    }
}

