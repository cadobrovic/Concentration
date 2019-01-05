//
//  Concentration Model.swift
//  Concentration Project
//
//  Created by Karlo Dobrović on 12/27/18.
//  Copyright © 2018 Karlo Dobrović. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    
    var score = 0
	
	static var highScore = 0
    
    var flipCount = 0
    
    var matchesCount = 0 {
        didSet {
            if matchesCount == 8 {
                gameWon = true
                print("Game Won!")
            }
        }
    }
    
    var gameWon = false
        
    var indexOfSoleFaceUpCard: Int?
    
    /**
     Makes two copies of Card instances for
     each pair given and appends them to the
     `cards` Array.
    */
    init(numberOfPairsOfCards: Int){
        print("Number of Pairs of Cards: \(numberOfPairsOfCards)")
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        shuffleCards()
        
    }
	
	/**
	 Takes the cards array and randomizes the
	 elements within.
	*/
    func shuffleCards() {
        for _ in 0...100 {
            for index in cards.indices {
                var temp = Card()
                temp = cards[index]
                let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
                cards[index] = cards[randomIndex]
                cards[randomIndex] = temp
            }//end inner for
        }//end outer for
    }//end func
	
    /**
	DO THIS DOCUMENTATION
	*/
    func chooseCard(at index: Int){
        flipCount += 1
        print("Index: \(index)")
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfSoleFaceUpCard, matchIndex != index
            {
                print("matchIndex: \(matchIndex)")
                if cards[matchIndex].identifier == cards[index].identifier
                {
                    print("Match! at indices index: \(index) and matchIndex: \(matchIndex)")
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    matchesCount += 1
                    score += 2
                    print("Score incremented by 2. Score now: \(score)")
                    print("matchesCount incremented by 1. Matches now: \(matchesCount)")
                    
                }
                else if cards[matchIndex].isSeen || cards[index].isSeen
                {
                    print("Already seen and mismatch!")
                    score -= 1
                    print("Score decremented by 1. Score now: \(score)")
                }
			//tags the chosen card as "seen"
			cards[index].isSeen = true
            cards[index].isFaceUp = true
            indexOfSoleFaceUpCard = nil
            }
            else
            {
                for flipDownIndex in cards.indices
                {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfSoleFaceUpCard = index
            }
        }
    }//end func
	
	static func setHighScore(score: Int) {
		if highScore < score {
			highScore = score
			print("---high score set: \(highScore)---")
		}
	}//end func
    
    
    func resetGame(numberOfPairsOfCards: Int) {
		print("Score Upon Reset: \(score)")
		Concentration.setHighScore(score: score)
		print("High Score Upon Reset: \(Concentration.highScore)")
        cards.removeAll()
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        score = 0
        flipCount = 0
        matchesCount = 0
        //TODO: make sure this won't cause error
        indexOfSoleFaceUpCard = nil
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
            cards[index].isSeen = false
        }
        shuffleCards()
        print("Game Reset!")
    }//end func
}
