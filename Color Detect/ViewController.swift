//
//  ViewController.swift
//  ColorDetect
//
//  Created by apple on 10/1/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet var tiles: [ColorButton]!
    @IBOutlet weak var scoreDescLabel: UILabel! //the name label
    @IBOutlet weak var scoreLabel: UILabel! //the actual score label
    @IBOutlet weak var timeDescLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var TilesStackView: UIStackView!
    
    let gameModel = ColorDetectModel();
    
    //things for the timer
    var seconds = 120;   //totoal game time
    var timer = Timer();

    override func viewDidLoad() {
        super.viewDidLoad();
        
        //list out the color button, and using the index to associate each color button with
        //a tile in the tilesArray and thus the color in the tilesArray
        for (i, tile) in tiles.enumerated() {
            tile.index = i
        }
        //initialize the score label with the localization
        scoreDescLabel.text = NSLocalizedString("str_score", comment: "");
        timeDescLabel.text = NSLocalizedString("str_time", comment: "");
        startBtn.setTitle(NSLocalizedString("str_start", comment: ""), for: .normal)
        
        //start the game
        gameModel.startGame(with: tiles.count);
    }
    
    func nextStage(){
        
        //set the new score
        scoreLabel.text = String(gameModel.score);
        
        for tile in tiles {
            //set the ColorButton's background color the same as the index in tilesArray in gameModel
            tile.backgroundColor = gameModel.getColor(with: tile.index);
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(_ sender: ColorButton) {
        let temp = sender.index;
        if gameModel.getBad(with: temp){
            gameModel.score += 10;
            gameModel.changeColor();
            nextStage();
        }
    }
    
    @IBAction func onStart(_ sender: UIButton) {
        
        nextStage();    //update the change on initialization
        startBtn.isHidden = true
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.count), userInfo: nil, repeats: true)
    }
    
    @objc func count(){
        seconds -= 1;   //minus the timer
        timeLabel.text = String(seconds);
        
        if(seconds == 0){
            timer.invalidate();
            TilesStackView.isHidden = true;
        }
    }
    
    //change the color setting
    @IBAction func Switch(_ sender: UISwipeGestureRecognizer) {
        gameModel.changeColor();
        nextStage();
    }


}

