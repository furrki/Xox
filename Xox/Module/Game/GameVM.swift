//
//  GameVM.swift
//  Xox
//
//  Created by Admin on 27.01.2019.
//  Copyright © 2019 furrki. All rights reserved.
//

import Foundation

class GameVM: GameDelegate {
    var gameTableChanged: (()->())?
    var gameTableClicked: (()->())?
    var reloadTableViewClosure: (()->())?
    var endGame: (()->())?
    
    var cellModels: [GameCellVM] = []
    
    init(){
        Game.shared = Game()
        Game.shared.dlg = self
        for square in Game.shared.table {
            let gcvm = GameCellVM()
            if let playerType = square.playerType {
                gcvm.sign = playerType.sign
            }
            cellModels.append(gcvm)
        }
        
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> GameCellVM {
        return cellModels[indexPath.row]
    }
    
    func clickItem(at indexPath: IndexPath) {
        Game.shared.doMove(at: indexPath.row, who: .player)
    }
    
    func game(finished whoWon: PlayerType?, condition: [Int]?) {
        if let condition = condition, let whoWon = whoWon {
            for index in condition {
                if whoWon == .player {
                    cellModels[index].success = true
                } else {
                    cellModels[index].fail = true
                }
            }
        }
        reloadTableViewClosure?()
        let _ = setTimeout(delay: 2.0) {
            self.endGame?()
        }
    }
    
    func game(tableChanged index: Int) {
        if Game.shared.table[index] == .player {
            cellModels[index].sign = PlayerType.player.sign
        } else if Game.shared.table[index] == .op {
            cellModels[index].sign = PlayerType.op.sign
        } else {
            cellModels[index].sign = ""
        }
        reloadTableViewClosure?()
    }
}




