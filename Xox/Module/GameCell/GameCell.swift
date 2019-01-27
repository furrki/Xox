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
    var vm: GameCellVM =  GameCellVM() {
        didSet {
            self.clabel.text = self.vm.sign
        }
    }
     
    override func awakeFromNib() {
        super.awakeFromNib() 
        clabel.text = vm.sign
    }
}
