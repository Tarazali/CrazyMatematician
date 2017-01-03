//
//  GameViewController.swift
//  Crazy Machematician
//
//  Created by macuser on 27.09.16.
//  Copyright © 2016 macuser. All rights reserved.
//

import UIKit
protocol GameViewControllerDelegate
{
    func gameScore(score: Int,name : String)
}
class GameViewController: UIViewController {

    @IBOutlet weak var questionLable: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var timerLable: UILabel!
    @IBOutlet weak var scoreLable: UILabel!
  
    
    var delegate:GameViewControllerDelegate?
    
    var x = 0
    var y = 0
    var gameTime = 30
    var score = 0
    var names: String = ""
    var speed:CGFloat = 5
    var counter = 0
    var number: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timerLable.text = "0:\(gameTime)"
        newQuestion()
        _=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.updateTimer), userInfo: nil, repeats: true)
        
        _=Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(GameViewController.moveQuestionLable), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func newQuestion()
    {
        self.x = Int(arc4random_uniform(UInt32(number)+1))
        self.y = Int(arc4random_uniform(UInt32(number)+1))
        
        self.questionLable.text = "\(self.x)X\(self.y)="
        self.questionLable.center.y = 50
    }
    
    func moveQuestionLable()
    {
        if(self.questionLable.center.y >= self.bottomView.center.y)
        {
            score = score - 2
            scoreLable.text = "Your score \(score)"
            newQuestion()
        }
        
        UIView.animate(withDuration: 0.5)
        {
                self.questionLable.center.y = self.questionLable.center.y + self.speed
        }
    }
    
    func updateTimer()
    {
        gameTime = gameTime-1
        self.timerLable.text = "0:\(gameTime)"
        
        if(gameTime == 0)
        {
            gameOver()
        }
    }
    
    func gameOver()
    {
       
        let alert = UIAlertController(title: "Game over!", message: "Your score is: \(score) \n Insert your name", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Your name"
            
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            let names = alert.textFields?[0].text
            self.delegate?.gameScore(score: self.score, name: names!)
            self.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
    func gameSpeed(counter :Int)
    {
        if(counter == 2)
        {
            speed = 10
        }
        else if(counter == 0)
        {
            speed = 5
        }
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton)
    {
    let res = Int(self.answerTextField.text!)
        if(number == 9)
        {
            if (res == x*y)
            {
                score = score + 1
                scoreLable.text = "Your score: \(score)"
                newQuestion()
                counter += 1
                if(counter == 2)
                {
                    gameSpeed(counter: 2)
                }
            }
            else
            {
                gameSpeed(counter: 0)
            }
        }
        else if(number == 99)
        {
            if (res == x*y)
            {
                score = score + 2
                scoreLable.text = "Your score: \(score)"
                newQuestion()
                counter += 1
                if(counter == 2)
                {
                    gameSpeed(counter: 2)
                }
            }
            else
            {
                gameSpeed(counter: 0)
            }
        }
        else
        {
            if (res == x*y)
            {
                score = score + 4
                scoreLable.text = "Your score: \(score)"
                newQuestion()
                counter += 1
                if(counter == 2)
                {
                    gameSpeed(counter: 2)
                }
            }
            else
            {
                gameSpeed(counter: 0)
            }
        }
        self.answerTextField.text = ""
    }
    
}


