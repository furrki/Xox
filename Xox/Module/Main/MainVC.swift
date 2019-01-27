//
//  ViewController.swift
//  Xox
//
//  Created by Admin on 27.01.2019.
//  Copyright © 2019 furrki. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.layer.cornerRadius = 6.0
        startGameButton.layer.cornerRadius = 6.0
    }


}

