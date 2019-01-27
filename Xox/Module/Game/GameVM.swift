//
//  GameVM.swift
//  Xox
//
//  Created by Admin on 27.01.2019.
//  Copyright © 2019 furrki. All rights reserved.
//

import Foundation

class GameVM {
    var gameTableChanged: (()->())?
    var gameTableClicked: (()->())?
    var reloadTableViewClosure: (()->())?
    
    init(){
        Game.shared.dlg = self
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> GameCellVM {
        let cvm = GameCellVM()
        if Game.shared.table[indexPath.row] == .player {
            cvm.sign = "X"
        } else if Game.shared.table[indexPath.row] == .op {
            cvm.sign = "O"
        } else {
            cvm.sign = ""
        }
        //        self.reloadTableViewClosure?()
        return cvm
    }
    
    func clickItem(at indexPath: IndexPath) {
        Game.shared.doMove(at: indexPath.row, who: .player)
    }
}

extension GameVM: GameDelegate {
    func game(tableChanged table: [SquareType]) {
        self.reloadTableViewClosure?()
    }
}



