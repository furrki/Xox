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
    
    func decide() -> Int{
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
