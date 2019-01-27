//
//  GameCell.swift
//  Xox
//
//  Created by Admin on 27.01.2019.
//  Copyright © 2019 furrki. All rights reserved.
//

import Foundation
import UIKit

class GameCell: UICollectionViewCell {
    @IBOutlet weak var clabel: UILabel!
    
    var vm: GameCellVM = GameCellVM()
    
    func initialize(vm: GameCellVM){
        self.vm = vm
        
        clabel.text = vm.sign
        if vm.success {
            self.contentView.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        } else if vm.fail {
            self.contentView.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        } else {
            self.contentView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
