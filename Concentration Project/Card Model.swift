//
//  Card Model.swift
//  Concentration Project
//
//  Created by Karlo Dobrović on 12/27/18.
//  Copyright © 2018 Karlo Dobrović. All rights reserved.
//

import Foundation

struct Card
{
    var isFaceUp = false
    var isMatched = false
    var isSeen = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    /**
     Increments static identifier for Card struct each time
     a new card is initialized.
     
     -Returns: An Int of the incremented identifier
    */
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    /**
     Initializes Card instances with unique identifier
     variables updated by the getUniqueIdentifier() function.     
    */
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
