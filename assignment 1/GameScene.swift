//
//  GameScene.swift
//  assignment 1
//commit check
//
//  Created by Abhishek Bansal on 2019-06-23.
//  Copyright © 2019 Abhishek Bansal. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player:SKNode!
    var level1 : SKNode!
    var level2 : SKNode!
    var level3 : SKNode!
    
    let enemy = SKSpriteNode(imageNamed: "enemy")
    var movingEnemyRight :Bool = true
    
    override func didMove(to view: SKView) {
        
    
        self.physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        self.player = self.childNode(withName: "player") as! SKSpriteNode
        self.level1 = self.childNode(withName: "lev1")
        self.level2 = self.childNode(withName: "lev2")
        self.level3 = self.childNode(withName: "lev3")
        
        var playerTextures:[SKTexture] = []
        for i in 1...4 {
            let fileName = "frame\(i)"
            print("Adding: \(fileName) to array")
            playerTextures.append(SKTexture(imageNamed: fileName))
        }
        
        let walkingAnimation = SKAction.animate(
            with: playerTextures,
            timePerFrame: 0.1)
        
        self.player.run(SKAction.repeatForever(walkingAnimation))
        
        
        self.makeEnemies()
    }
    
    func moveShip (moveBy: CGFloat, forTheKey: String) {
        let moveAction = SKAction.moveBy(x: moveBy, y: 0, duration: 1)
        let repeatForEver = SKAction.repeatForever(moveAction)
        let seq = SKAction.sequence([moveAction, repeatForEver])
        
        //run the action on your ship
        player.run(seq, withKey: forTheKey)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        let touch = touches.first
        if (touch == nil) {
            return
        }
        
        let mouseLocation = touch!.location(in:self)
        let spriteTouched = self.atPoint(mouseLocation)
        
        
        if (spriteTouched.name == "jumpButton") {
            print("PRESSED THE BUTTON")
            
            let jumpAction = SKAction.applyImpulse(
                CGVector(dx:0, dy:2000),
                duration: 0.5)
            
            self.player.run(jumpAction)
            
            
            
        }
        
        
        
        
        if (spriteTouched.name == "up") {
            print("UP PRESSED")
            if(self.player.position.y <= self.frame.size.height-250)
            {
                self.player.position.y = self.player.position.y + 150
            }
            
            
        }
        else if (spriteTouched.name == "down") {
            print("DOWN PRESSED")
            if(self.player.position.y >= 150)
            {
                self.player.position.y = self.player.position.y - 150
            }
        }
        else if (spriteTouched.name == "left") {
            print("LEFT PRESSED")
            
            self.player.position.x = self.player.position.x - 50
        }
        else if (spriteTouched.name == "right") {
            print("RIGHT PRESSED")
            self.player.position.x = self.player.position.x + 50
        }
        
    }
    
    var timeOfLastUpdate:TimeInterval?
    override func update(_ currentTime: TimeInterval) {
        
        
        //self.player.position.x = self.player.position.x + 10
        
        if (self.player.position.x >= self.size.width) {
            self.player.position.x = 10
        }
        if (self.player.position.x < 0) {
            self.player.position.x = self.size.width-100
        }
        
        //move enemy
        
        
        if(movingEnemyRight == true)
        {
            let RightMoveAction = SKAction.scaleX(to: +1, duration: 0)
            self.enemy.run(RightMoveAction)
            enemy.position.x =     enemy.position.x + 10;
            if(enemy.position.x >= self.frame.width)
            {
                movingEnemyRight = false
            }
        }
        else if (movingEnemyRight == false){
            
            let leftMoveAction = SKAction.scaleX(to: -1, duration: 0)
            self.enemy.run(leftMoveAction)
            enemy.position.x =     enemy.position.x - 10;
            if(enemy.position.x <= 0)
            {
                movingEnemyRight = true
            }
            
        }
        
        //        if (timeOfLastUpdate == nil) {
        //            timeOfLastUpdate = currentTime
        //        }
        //        // print a message every 3 seconds
        //        var timePassed = (currentTime - timeOfLastUpdate!)
        //        if (timePassed >= 1.5) {
        //            print("HERE IS A MESSAGE!")
        //            timeOfLastUpdate = currentTime
        //            // make a cat
        //            self.makeEnemies()
        //        }
        //
    }
    
    func makeEnemies() {
        // lets add some enemies
        // generate a random (x,y) for the cat
        let randX = Int(level1.position.x)
        let randY = Int(level1.position.y + 80)
        enemy.position = CGPoint(x:randX, y:randY)
        print("enemy position \(randX) \(randY)")
        addChild(enemy)
        
    }
    
}
