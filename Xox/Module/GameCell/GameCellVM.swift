//
//  GameCellVM.swift
//  Xox
//
//  Created by Admin on 27.01.2019.
//  Copyright © 2019 furrki. All rights reserved.
//

import Foundation
class GameCellVM {
    var sign: String = "" {
        didSet {
            if reloadClosure != nil {
                reloadClosure!()
            }
        }
    }
    
    var reloadClosure: (()->())?
}
