//
//  ViewController.swift
//  Crazy Machematician
//
//  Created by macuser on 27.09.16.
//  Copyright © 2016 macuser. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var scoreLable: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var bestScore = 0
    var bestName = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        bestScore = UserDefaults.standard.integer(forKey: "bestScore")
        bestName = UserDefaults.standard.string(forKey: "name")!
        
        self.scoreLable.text = "\(bestScore)"
        self.nameLabel.text = "\(bestName)"
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playButtonPressed(_ sender: UIButton)
    {
        let alert = UIAlertController(title: "Choose level", message: "Please, choose level:", preferredStyle: .alert)
        let easy = UIAlertAction(title: "Easy", style: .default) { (UIAlertAction) in
            self.performSegue(withIdentifier: "toGameVC", sender: 9)
        }
        let norm = UIAlertAction(title: "Norm", style: .default) { (UIAlertAction) in
            self.performSegue(withIdentifier: "toGameVC", sender: 99)
        }
        let hard = UIAlertAction(title: "Hard", style: .default) { (UIAlertAction) in
            self.performSegue(withIdentifier: "toGameVC", sender: 999)
        }
        alert.addAction(easy)
        alert.addAction(norm)
        alert.addAction(hard)
        
        present(alert, animated: true, completion: nil)

        //self.performSegue(withIdentifier: "toGameVC", sender: nil)
    
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if(segue.destination.isKind(of: GameViewController.self))
        {
            let gameVC = segue.destination as! GameViewController
            gameVC.delegate = self
            let number = sender as! Int
            gameVC.number = number
        }
    }
}

extension ViewController: GameViewControllerDelegate
{
    func gameScore(score:Int,name:String)
    {
        if(score>bestScore)
        {
            bestScore = score
            bestName = name
            UserDefaults.standard.set(bestScore, forKey: "bestScore")
            UserDefaults.standard.setValue(name, forKey: "name")
        }
        
        self.scoreLable.text = "\(bestScore)"
        self.nameLabel.text = "\(bestName)"
    }
}
