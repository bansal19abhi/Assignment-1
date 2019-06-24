//
//  GameOver.swift
//  assignment 1
//
//  Created by Abhishek Bansal on 2019-06-24.
//  Copyright © 2019 Abhishek Bansal. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameOver: SKScene {
    
    
    
    
    override func didMove(to view: SKView) {
        print("Loaded Game Over Scene")
        
    }
    var timeOfLastUpdate:TimeInterval?
    var restart: Int = 0
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        //set time for make cats on levels
        if (timeOfLastUpdate == nil) {
            timeOfLastUpdate = currentTime
        }
        // print a message every 3 seconds
        var timePassed = (currentTime - timeOfLastUpdate!)
        if (timePassed >= 1) {
            restart = 1
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if (touch == nil) {
            return
        }
        else{
            if(restart == 1)
            {
                let scene = SKScene(fileNamed:"GameScene")
                scene!.scaleMode = .aspectFill
                view?.presentScene(scene!)
            }
        }
        
        let location = touch!.location(in:self)
        let node = self.atPoint(location)
        
        
    }
}
