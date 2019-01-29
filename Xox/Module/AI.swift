//
//  AI.swift
//  Xox
//
//  Created by Admin on 27.01.2019.
//  Copyright © 2019 furrki. All rights reserved.
//

import Foundation

class AI {
    
    var game: Game
    
    init(game: Game) {
        self.game = game
    }
    
    func selectables(table: [SquareType]) -> [Int] {
        return self.game.table.enumerated()
            .filter { $0.element == SquareType.empty }
            .map {
                return $0.offset
        }
    }
    
    
    func min(table: [SquareType]) -> Double {
        let winConditions = game.winConditions
        var score = 1
        var min = 50.0
        for condition in winConditions {
            score = 1
            if table[condition[0]] != .player && table[condition[1]] != .player && table[condition[2]] != .player {
                for i in 1...3 {
                    if table[condition[i]] == .op {
                        score /= 2
                    }
                }
            }
            if table[condition[0]] != .op && table[condition[1]] != .op && table[condition[2]] != .op {
                for i in 1...3 {
                    if table[condition[i]] == .player {
                        score *= 2
                    }
                }
            }
            min = Double.minimum(Double(score), Double(min))
        }
        return min
    }
    
    func max(table: [SquareType]) -> Double {
        let winConditions = game.winConditions
        var score = 1
        var max = 0.0
        for condition in winConditions {
            score = 1
            if table[condition[0]] != .player && table[condition[1]] != .player && table[condition[2]] != .player {
                for i in 1...3 {
                    if table[condition[i]] == .op {
                        score *= 2
                    }
                }
            }
            if table[condition[0]] != .op && table[condition[1]] != .op && table[condition[2]] != .op {
                for i in 1...3 {
                    if table[condition[i]] == .player {
                        score /= 2
                    }
                }
            }
            max = Double.maximum(Double(score), Double(max))
        }
        return max
    }
    
    func decide() -> Int {
        if game.checkFinish() {
            return -1
        }
        var decided = Int.random(in: 0..<self.game.table.count)
        while self.game.table[decided] != SquareType.empty {
            decided = Int.random(in: 0..<self.game.table.count)
        }
        return decided
    }

}
