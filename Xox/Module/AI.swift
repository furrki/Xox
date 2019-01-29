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
    
    
    func playerMax(table: [SquareType]) -> Double {
        let winConditions = game.winConditions
        var score = 1
        var max = 0.0
        for condition in winConditions {
            score = 1
//
//            if table[condition[0]] != .player && table[condition[1]] != .player && table[condition[2]] != .player {
//                for i in 0...2 {
//                    if table[condition[i]] == .op {
//                        score /= 2
//                    }
//                }
//            }
            if table[condition[0]] != .op && table[condition[1]] != .op && table[condition[2]] != .op {
                for i in 0...2 {
                    if table[condition[i]] == .player {
                        score *= 2
                    }
                }
            }
            max = Double.maximum(Double(score), Double(max))
        }
        return max
    }
    
    func opMax(table: [SquareType]) -> Double {
        let winConditions = game.winConditions
        var score = 1
        var max = 0.0
        for condition in winConditions {
            score = 1
            if table[condition[0]] != .player && table[condition[1]] != .player && table[condition[2]] != .player {
                for i in 0...2 {
                    if table[condition[i]] == .op {
                        score *= 2
                    }
                }
            }
//            if table[condition[0]] != .op && table[condition[1]] != .op && table[condition[2]] != .op {
//                for i in 0...2 {
//                    if table[condition[i]] == .player {
//                        score /= 2
//                    }
//                }
//            }
            max = Double.maximum(Double(score), Double(max))
        }
        return max
    }
    
    func max(_ t: [SquareType]) -> Array<Any> {
        var table = t
        var scores: [Double] = []
        var indexes: [Int] = []
        let selectables = self.selectables(table: table)
        
        var max = 0.0
        var score = 0.0
        
        for index in selectables {
            table[index] = .op
            score = opMax(table: table)
            scores.append(score)
            indexes.append(index)
            max = Double.maximum(max, score)
        }
        return [table, indexes, scores]
    }
    
    func min(_ t: [SquareType]) -> Array<Any> {
        var table = t
        var scores: [Double] = []
        var indexes: [Int] = []
        let selectables = self.selectables(table: table)
        
        var max = 0.0
        var score = 0.0
        
        for index in selectables {
            table[index] = .op
            score = playerMax(table: table)
            scores.append(score)
            indexes.append(index)
            max = Double.maximum(max, score)
        }
        return [table, indexes, scores]
    }
    
    func minmax() -> Int{
        var table = self.game.table
        var tis = max(table)
        var t = tis[0] as! [SquareType]
        var i = tis[1] as! [Int]
        var s = tis[2] as! [Double]
        
        var minn = 50.0
        var si = 0
        for index in i {
            var nextTable = table
            nextTable[index] = .op
            var tis2 = min(nextTable)
            var t2 = tis2[0] as! [SquareType]
            var i2 = tis2[1] as! [Int]
            var s2 = tis2[2] as! [Double]
            if minn < s2.min()! {
                si = index
            }
            minn = Double.minimum(s2.min()!, minn)
        }
        return si
    }
    
    func decide() -> Int {
        if game.checkFinish() {
            return -1
        }
        var decided = minmax()
        return decided
    }

}
