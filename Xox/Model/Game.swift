//
//  Game.swift
//  Xox
//
//  Created by Admin on 27.01.2019.
//  Copyright © 2019 furrki. All rights reserved.
//

import Foundation

class Game {
    static var shared = Game()
    var dlg: GameDelegate?
    
    var situation: GameSituation = .playerTurn
    
    let playerSign = "X"
    let opSign = "O"
    var ai: AI!
    
    var table: [SquareType] = []
    
    init() {
        
        for _ in 1...9 {
            table.append(.empty)
        }
        
        ai = AI(game: self)
        if Bool.random() {
            situation = .opTurn
            doMove(at: ai.decide(), who: .op)
        }
    }
    
    func doMove(at index: Int, who player: PlayerType) {
        let cell = table[index]
        if cell == .empty {
            table[index] = player.square
            
            dlg?.game(tableChanged: table)
            if checkFinish() {
                situation = .final
            } else {
                situation = situation.opposite
                
                if player == .player {
                    doMove(at: ai.decide(), who: .op)
                }
            }
            
        }
    }
    
    func checkFinish() -> Bool {
        if table.filter({ $0 == SquareType.empty }).count == 0 {
            return true
        }
        return false
    }
    
}

protocol GameDelegate {
    func game(tableChanged table: [SquareType])
}


//============== Player Type
enum PlayerType {
    case player, op
}

extension PlayerType {
    var sign: String {
        switch self {
        case .player:
            return "X"
        case .op:
            return "O"
        }
    }
    var square: SquareType {
        switch self {
        case .player:
            return .player
        case .op:
            return .op
        }
    }
}

//------------------

enum SquareType {
    case player, op, empty
}
//----------------------
enum GameSituation {
    case playerTurn, opTurn, final
}
extension GameSituation {
    var opposite: GameSituation {
        if self == .playerTurn {
            return .opTurn
        }
        return .playerTurn
    }
}
//------------------------------


