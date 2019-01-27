//
//  GameVC.swift
//  Xox
//
//  Created by Admin on 27.01.2019.
//  Copyright © 2019 furrki. All rights reserved.
//

import UIKit

class GameVC: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    lazy var vm: GameVM = {
        return GameVM()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        initVM()
    }
    
    func initViews(){
        collectionView.layer.cornerRadius = 6.0
        containerView.layer.cornerRadius = 6.0
    }
    
    func initVM() {
        vm.gameTableChanged = {
            self.collectionView.reloadData()
        }
        vm.gameTableClicked = {
            self.collectionView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}
