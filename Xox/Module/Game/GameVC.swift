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
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsSelection = true
    }
    
    func initVM() {
        vm.gameTableChanged = {
            self.collectionView.reloadData()
             
        }
        vm.gameTableClicked = {
            self.collectionView.reloadData()
        }
        vm.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self!.collectionView.reloadData()
            }
        }
        vm.endGame = {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}

extension GameVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameCell", for: indexPath) as? GameCell else {
            fatalError("Cell not exists in storyboard")
        }
        
        let cellVM = vm.getCellViewModel( at: indexPath )
        cell.initialize(vm: cellVM) 
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        vm.clickItem(at: indexPath)
    }
}


