//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Dennis Tarasula on 02/16/2024
//
//  Improvements:
//  1. The app is now a game of high-low. The objective of the game
//      is to guess if the sum of your dice roll will be higher or
//      lower than the dealers. The dealer rolls first and you must
//      choose higher or lower before you roll.
//
//  2. Added a new set of dice for the dealer.
//
//  3. Added scoring system and button hiding.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dealerDiceImageView1: UIImageView!
    @IBOutlet weak var dealerDiceImageView2: UIImageView!
    @IBOutlet weak var playerDiceImageView1: UIImageView!
    @IBOutlet weak var playerDiceImageView2: UIImageView!
    
    @IBOutlet weak var dealerTotalLabel: UILabel!
    @IBOutlet weak var playerTotalLabel: UILabel!
    @IBOutlet weak var youLostTextLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var playUIButton: UIButton!
    @IBOutlet weak var higherUIButton: UIButton!
    @IBOutlet weak var lowerUIButton: UIButton!
    @IBOutlet weak var nextUIButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        youLostTextLabel.isHidden = true
        dealerTotalLabel.isHidden = true
        playerTotalLabel.isHidden = true
        higherUIButton.isHidden = true
        lowerUIButton.isHidden = true
        nextUIButton.isHidden = true
        scoreLabel.isHidden = true
        scoreLabel.text = "0"
    }
    
    let diceArray = [#imageLiteral(resourceName: "DiceOne"), #imageLiteral(resourceName: "DiceTwo"), #imageLiteral(resourceName: "DiceThree"), #imageLiteral(resourceName: "DiceFour"), #imageLiteral(resourceName: "DiceFive"), #imageLiteral(resourceName: "DiceSix")]
    var playerTotal = 0
    var dealerTotal = 0
    var score = 0
    var playerChoseHigher = false
    
    func setDiceImageViewsAndTotals(imageView1: UIImageView, imageView2: UIImageView, totalLabel: UILabel) -> Int {
        let rand1 = Int.random(in: 0...5)
        let rand2 = Int.random(in: 0...5)
        let diceTotal = rand1 + rand2 + 2
        imageView1.image = diceArray[rand1]
        imageView2.image = diceArray[rand2]
        totalLabel.text = String(diceTotal)
        return diceTotal
    }
    
    func dealerRoll(){
        dealerTotal = setDiceImageViewsAndTotals(imageView1: dealerDiceImageView1, imageView2: dealerDiceImageView2, totalLabel: dealerTotalLabel)
        playerDiceImageView1.image = diceArray[0]
        playerDiceImageView2.image = diceArray[0]
        youLostTextLabel.isHidden = true
        higherUIButton.isHidden = false
        lowerUIButton.isHidden = false
    }
    
    func playerRoll(playerChoseHigher : Bool) {
        playerTotalLabel.isHidden = false
        playerTotal = setDiceImageViewsAndTotals(imageView1: playerDiceImageView1, imageView2: playerDiceImageView2, totalLabel: playerTotalLabel)
        if(playerChoseHigher && playerTotal > dealerTotal) || (!playerChoseHigher && playerTotal < dealerTotal){
            score += 1
            scoreLabel.text = String(score)
            nextUIButton.isHidden = false
            higherUIButton.isHidden = true
            lowerUIButton.isHidden = true
        } else {
            youLostTextLabel.isHidden = false
            resetGameButtons()
        }
    }
    
    func resetGameButtons() {
        nextUIButton.isHidden = true
        higherUIButton.isHidden = true
        playUIButton.isHidden = false
        lowerUIButton.isHidden = true
    }
    
    @IBAction func playButtonPressed(_ sender: Any) {
        dealerRoll()
        dealerTotalLabel.isHidden = false
        playerTotalLabel.isHidden = true
        playUIButton.isHidden = true
        scoreLabel.isHidden = false
        scoreLabel.text = "0"
        score = 0
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        dealerRoll()
        nextUIButton.isHidden = true
        playUIButton.isHidden = true
        playerTotalLabel.isHidden = true
    }
    
    @IBAction func higherButtonPressed(_ sender: Any) {
        playerRoll(playerChoseHigher: true)
    }
    
    @IBAction func lowerButtonPressed(_ sender: Any) {
        playerRoll(playerChoseHigher: false)
    }
}
