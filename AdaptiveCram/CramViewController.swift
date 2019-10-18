//
//  CramViewController.swift
//  AdaptiveCram
//
//  Created by 문은서 on 13/10/2019.
//

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
    
}
