//
//  ViewController.swift
//  Concentration Project
//
//  Created by Karlo Dobrović on 12/27/18.
//  Copyright © 2018 Karlo Dobrović. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Setting BG Color
    var bgColor = UIColor.black {
        didSet {
            self.view.backgroundColor = bgColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = bgColor
    }
 
    
    lazy var game = Concentration(numberOfPairsOfCards: cardButtons.count / 2)
    
    @IBOutlet var cardButtons: [UIButton]!
    
    //default theme is 0 - Halloween
    var emojiTheme = 0
    
    var faceDownColor: UIColor!
    
    var isExplicitlyThemed = false
    
//    @IBOutlet weak var flipCountLabel: UILabel!
	
	@IBOutlet weak var highScoreLabel: UILabel!
	
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var matchesLabel: UILabel!
    
    @IBOutlet weak var themeLabel: UILabel!
    
    @IBOutlet weak var themeSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var newGameLabel: UIButton!
    
    @IBAction func touchNewGame(_ sender: UIButton) {
        newGame()
    }//end func
    
    func newGame() {
        game.resetGame(numberOfPairsOfCards: cardButtons.count / 2)
        setEmojiChoices(withEmojiTheme: emojiTheme)
        updateViewFromModel()
    }
    
    
    /**
     Updates the View assets when the UISegmentedControl passes
     a selectedSegmentIndex value. Updates the emojiTheme as well.
     
     -Parameter sender: the themeSegmentedControl button.
    */
    @IBAction func themeChanged(_ sender: UISegmentedControl) {
        game.resetGame(numberOfPairsOfCards: cardButtons.count / 2)
        updateViewFromModel()
        isExplicitlyThemed = true
        switch sender.selectedSegmentIndex{
        case 0:
            print("Halloween Theme Chosen")
            updateAssetsWithTheme(withTint: UIColor.orange, withSet: UIColor.black)
            emojiTheme = 0
            setEmojiChoices(withEmojiTheme: emojiTheme)
        case 1:
            print("Sports Theme Chosen")
            updateAssetsWithTheme(withTint: UIColor.black, withSet: UIColor.green)
            emojiTheme = 1
            setEmojiChoices(withEmojiTheme: emojiTheme)
        case 2:
            print("Faces Theme Chosen")
            updateAssetsWithTheme(withTint: UIColor.yellow, withSet: UIColor.blue)
            emojiTheme = 2
            setEmojiChoices(withEmojiTheme: emojiTheme)
		case 3:
			//aniMoji
			print("Animal Theme Chosen")
			updateAssetsWithTheme(withTint: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), withSet: #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1))
			emojiTheme = 3
			setEmojiChoices(withEmojiTheme: emojiTheme)
		case 4:
			//vehiMoji
			print("Vehicle Theme Chosen")
			updateAssetsWithTheme(withTint: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), withSet: #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1))
			emojiTheme = 4
			setEmojiChoices(withEmojiTheme: emojiTheme)
        default:
            break;
        }
    }//end func
    
    /**
     Sets View assets to colors pulled from segmentedControl cases.
     
     -Parameter tintColor: The highlight color of text and foreground.
     
     -Parameter setColor: The shadow color of the background elements.
    */
    func updateAssetsWithTheme(withTint tintColor: UIColor, withSet setColor: UIColor) {
        bgColor = setColor
        scoreLabel.textColor = tintColor
		//TODO: delete flipCount label
//        flipCountLabel.textColor = tintColor
		highScoreLabel.textColor = tintColor
        themeLabel.textColor = tintColor
        themeSegmentedControl.tintColor = tintColor
        newGameLabel.backgroundColor = tintColor
        newGameLabel.setTitleColor(setColor, for: UIControl.State.normal)
        matchesLabel.textColor = tintColor
        faceDownColor = tintColor
        for index in cardButtons.indices {
            if !game.cards[index].isFaceUp {
                cardButtons[index].backgroundColor = tintColor
            }
        }
    }//end func
    
    
    
    /**
     Sends the Concentration Model commands to choose a card
     and updates the view with the Model's modifications.
    */
    @IBAction func touchCard(_ sender: UIButton) {
        print("Card Touched!")
        if let cardIndex = cardButtons.firstIndex(of: sender){
            print("cardIndex of touched card: \(cardIndex)")
            game.chooseCard(at: cardIndex)
            updateViewFromModel()
        } else {
            print("Chosen Card not in cardButtons")
        }
    }//end func
    
    func updateViewFromModel() {
        if !isExplicitlyThemed {
            faceDownColor = UIColor.orange
        }
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(setEmoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = UIColor.white
            }
            else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : faceDownColor
            }
			//TODO: delete flipCount label
//            flipCountLabel.text = "Flip Count: \(game.flipCount)"
			
			//TODO: highScoreLabel.text = "High Score: \(Concentration.highScore)
        }
		scoreLabel.text = "Score: \(game.score)"
		matchesLabel.text = "Matches: \(game.matchesCount)"
		highScoreLabel.text = "High Score: \(Concentration.highScore)"
		print("High Score Now: \(Concentration.highScore)")
        
    }//end func
    
    ////// Emoji Themes //////
    var hallowMoji = ["👻", "🎃", "😱", "🍎", "🍭", "🦇", "👺", "👽"]
    var sportMoji = ["⚽️", "🏓", "🏈", "⚾️", "🏀", "🥊", "🎾", "⛳️"]
    var faceMoji = ["😀", "😂", "🤩", "🤪", "😎", "🤯", "🤬", "🥶"]
	var aniMoji = ["🐬", "🐅", "🐆", "🦈", "🦋", "🦅", "🦉", "🐋"]
	var vehiMoji = ["✈️", "🚅", "🛰", "🚀", "🚔", "⛵️", "🚁", "🏎"]
    ////// Emoji Themes //////
    
    var emojiChoices = Array<String>()
    
    var hasEmojiChoicesSet = false
    
    func setEmojiChoices(withEmojiTheme: Int) {
        hasEmojiChoicesSet = true
        switch withEmojiTheme {
        case 0:
            emojiChoices = hallowMoji
            print("Emoji Choices: \(emojiChoices)")
        case 1:
            emojiChoices = sportMoji
            print("Emoji Choices: \(emojiChoices)")
        case 2:
            emojiChoices = faceMoji
            print("Emoji Choices: \(emojiChoices)")
		case 3:
			emojiChoices = aniMoji
			print("Emoji Choices: \(emojiChoices)")
		case 4:
			emojiChoices = vehiMoji
			print("Emoji Choices: \(emojiChoices)")
        default:
            break;
        }
    }
    
    var emojiDictionary = [Int:String]()
    
    func setEmoji(for card: Card) -> String {
        if !hasEmojiChoicesSet {
            print("Emoji Choices Not Set")
            //default theme is 0 - Halloween
            setEmojiChoices(withEmojiTheme: emojiTheme)
        }
        
        if emojiDictionary[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emojiDictionary[card.identifier] = emojiChoices.remove(at: randomIndex)
            print("Emoji: \(emojiDictionary[card.identifier]!) assigned to Identifier: \(card.identifier)")
            print("Emoji Choices after removal: \(emojiChoices)")
        }
        return emojiDictionary[card.identifier] ?? "?"
    }
    
	
    
    



}

