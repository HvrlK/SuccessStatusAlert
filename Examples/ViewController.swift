//
//  ViewController.swift
//  Examples
//
//  Created by Vitalii Havryliuk on 25.09.2019.
//

import UIKit
import SuccessStatusAlert

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func copyButtonDidTap() {
        showSuccessStatusAlert(title: "Copied")
    }


}

