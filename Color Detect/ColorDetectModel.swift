//
//  ColorDetectModel.swift
//  ColorDetect
//
//  Created by apple on 10/1/18.
//  Copyright © 2018 apple. All rights reserved.
//

import Foundation
import UIKit

struct Tile{
    var bad = false;
    //as default, tile has black color
    var color = UIColor.black;
}

class ColorDetectModel{
    //Potential color will be used in game
    let red = UIColor.red;
    let closeRed = UIColor.init(named: "closeRed");
    let blue = UIColor.blue;
    let closeBlue = UIColor.init(named: "closeBlue");
    let green = UIColor.green;
    let closeGreen = UIColor.init(named: "closeGreen");
    let orange = UIColor.orange;
    let closeOrange = UIColor.init(named: "closeOrange");
    let pink = UIColor.magenta;
    let closePink = UIColor.init(named: "closePink");
    
    private var tilesArray = [Tile]();
    private var numberOfTiles = 0;
    private var currentIndex = 1;   //to prevent in future when switch color, same color appears
    private var goodColor = UIColor.black;
    private var badColor = UIColor.black;
    
    var score = 0;
    
    //the function that start the game
    func startGame(with numberOfTiles : Int){
        self.numberOfTiles = numberOfTiles;
        changeColor();
    }
    
    //the method that get the color from the tile
    func getColor(with index: Int) -> UIColor?{
        return tilesArray[index].color;
    }
    
    func getBad(with index: Int) -> BooleanLiteralType{
        return tilesArray[index].bad;
    }
    
    //function that change color of the tiles
    //after running this function, the tiles array store new color for UIColorButton
    func changeColor(){
        //empty the original array
        tilesArray = [Tile]();
        
        //the if loop make sure the two index not the same
        var temp = 1 + Int(arc4random_uniform(UInt32(5)));
        while(currentIndex == temp){    //keep generating
            temp = 1 + Int(arc4random_uniform(UInt32(5)));
        }
        currentIndex = temp;
        
        if(currentIndex == 1){
            goodColor = red;
            badColor = closeRed!;
        }
        else if(currentIndex == 2){
            goodColor = blue;
            badColor = closeBlue!;
        }
        else if(currentIndex == 3){
            goodColor = green;
            badColor = closeGreen!;
        }
        else if(currentIndex == 4){
            goodColor = orange;
            badColor = closeOrange!;
        }
        else if(currentIndex == 5){
            goodColor = pink;
            badColor = closePink!;
        }
        
        //after one knows the good and bad color, set the tile array
        //random generate an index for putting the badTile
        let bad = Int(arc4random_uniform(UInt32(numberOfTiles)));
        for i in stride(from: 0, to: numberOfTiles, by: 1) {
            var tile = Tile(bad: true, color: badColor)
            if i != bad{    //if not bad, change the tile
                tile = Tile(bad: false, color: goodColor)
            }
            tilesArray.append(tile);
        }
        
    }
    
}
