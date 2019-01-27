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
        for (i, cell) in self.game.table.enumerated() {
            if cell == .empty {
                return i
            }
        }
        return 0
    }

}
