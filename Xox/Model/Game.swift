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
    
    let winConditions = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
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
        if situation == .final {
            return
        }
        let cell = table[index]
        if cell == .empty {
            table[index] = player.square
            dlg?.game(tableChanged: index)
            if checkFinish() {
                situation = .final
                dlg?.game(finished: whoWon()!, condition: wonCondition()!)
            } else {
                situation = situation.opposite
                if player == .player {
                    doMove(at: ai.decide(), who: .op)
                }
            }
        }
    }
    
    func checkFinish() -> Bool {
        if table.filter({ $0 == SquareType.empty }).count == 0 || whoWon() != nil {
            return true
        }
        return false
    }
    
    func whoWon() -> PlayerType? {
        for condition in winConditions {
            if table[condition[0]] == table[condition[1]] && table[condition[1]] == table[condition[2]] && table[condition[0]] != .empty {
                return table[condition[0]].playerType!
            }
        }
        return nil
    }
    
    func wonCondition() -> [Int]? {
        for condition in winConditions {
            if table[condition[0]] == table[condition[1]] && table[condition[1]] == table[condition[2]] && table[condition[0]] != .empty {
                return condition
            }
        }
        return nil
    }
}

protocol GameDelegate {
    func game(tableChanged index: Int)
    func game(finished whoWon: PlayerType, condition: [Int])
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
extension SquareType {
    var playerType: PlayerType? {
        switch self {
        case .player:
            return .player
        case .op:
            return .op
        default:
            return nil
        }
    }
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




