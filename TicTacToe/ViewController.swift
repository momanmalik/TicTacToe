//
//  ViewController.swift
//  TicTacToe
//
//  Created by Moman Malik on 2020-05-16.
//  Copyright © 2020 Moman Malik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var retry: UIButton!
    @IBOutlet weak var xScore: UILabel!
    @IBOutlet weak var oScore: UILabel!
    var turn: Bool = true
    var gameX = Set<Int>()
    var gameO = Set<Int>()
    var gameWin = false
    var xScore_ = 0
    var oScore_ = 0
    var winner = ""
    var winning = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        retry.isHidden = true
    }
    @IBAction func retryPressed(_ sender: UIButton) {
        gameX = Set<Int>()
        gameO = Set<Int>()
        gameWin = false
        winner = ""
        heading.text = ""
        turn = true
        for tagvalue in 101...109
        {
            let btnTemp = self.view.viewWithTag(tagvalue) as! UIButton;
            btnTemp.isEnabled = true;
            btnTemp.setTitle("",for: .normal)
        }
        retry.isHidden = true
    }
    @IBAction func buttonPress(_ sender: UIButton) {
        if !gameWin{
            let location = Double(sender.accessibilityLabel!)!

            if turn{
                sender.setTitle("X", for: .normal)
                gameX.insert(Int(location-1))
                (gameWin, winner) = checkWin(other: gameO,current: gameX, player: "X")

            }else{
                sender.setTitle("O", for: .normal)
                gameO.insert(Int(location-1))
                (gameWin, winner) = checkWin(other: gameX,current: gameO, player: "O")
            }
            sender.isEnabled = false
            turn = !turn
//            print(gameX)
//            print(gameO)
        }
        if gameWin{
            if winner != "tied"{
                if winner == "X"{
                    xScore_ += 1
                    xScore.text = "X: \(xScore_)"
                }else if winner == "O"{
                    oScore_ += 1
                    oScore.text = "O: \(oScore_)"
                }
                heading.text = "\(winner) won!"
            }else{
                heading.text = "It's a tie!"
            }
            retry.isHidden = false
        }
    }
    func checkWin(other: Set<Int>,current: Set<Int>,player: String) -> (Bool, String){
        var allElemsContained = false
        var count = 0
        var win = false
        let size = current.count + other.count
        var player = player
        while count < 8 && allElemsContained == false{
            let listSet = Set(winning[count])
            allElemsContained = listSet.isSubset(of: current)
//            print(allElemsContained)
            count += 1
        }
        if allElemsContained == true {
            win = true
        }else if size >= 9{
            win = true
            player = "tied"
        }
        return (win, player)
    }
}




