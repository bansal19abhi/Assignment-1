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
    var playerDir:String = ""
    var level1 : SKNode!
    var level2 : SKNode!
    var level3 : SKNode!
    var lev1Enemies:[SKSpriteNode] = []
    var lev2Enemies:[SKSpriteNode] = []
    var lev3Enemies:[SKSpriteNode] = []
    
    let livesLabel = SKLabelNode(text: "Lives: ")
    
   

    var movingEnemyRight :Bool = true
    var lives = 4
    
    override func didMove(to view: SKView) {
         // sound
        let backgroundSound = SKAudioNode(fileNamed: "loop.mp3")
        
        self.addChild(backgroundSound)
        // MARK: Add a lives label
        // ------------------------
        self.livesLabel.text = "Lives: \(self.lives)"
        self.livesLabel.fontName = "Avenir-Bold"
        self.livesLabel.fontColor = UIColor.yellow
        self.livesLabel.fontSize = 40;
        self.livesLabel.position = CGPoint(x:500,y:200)
        
        
        // MARK: Add your sprites to the screen
        addChild(livesLabel)
    
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
    
    func didBegin(_ contact: SKPhysicsContact) {
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node
        
        print("Collision detected!")
        print("Node A: \(nodeA?.name)  Node B: \(nodeB?.name)")
        if(nodeA?.name == "player" && nodeB?.name == "enemy")
        {
            if(playerDir == "left" || playerDir == "right" || playerDir == "no movement")
            {
                self.lives = self.lives-1
                
                print("lives after collision  \(self.lives)" )
                
                if (self.lives <= 0)
                {
                    print("-------- GAME LOST -----------")
                }
                else {
                    print("m in else")
                }
            }
            else if(playerDir == "down"){
                nodeB?.removeFromParent()
                }
        }
        
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
            playerDir = "up"
            print("UP PRESSED")
            if(self.player.position.y <= 120)
            {
                print ("height : \(self.player.position.y)")
                self.player.position.y = self.player.position.y + 200
            }
            
            
        }
        else if (spriteTouched.name == "down") {
            print("DOWN PRESSED")
            playerDir = "down"
            if(self.player.position.y >= -100)
            {
                print ("height : \(self.player.position.y)")
                self.player.position.y = self.player.position.y - 200
            }
        }
        else if (spriteTouched.name == "left") {
            print("LEFT PRESSED")
            playerDir = "left"
            self.player.position.x = self.player.position.x - 50
        }
        else if (spriteTouched.name == "right") {
            print("RIGHT PRESSED")
            playerDir = "right"
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
        
        for i in 0..<lev1Enemies.count {
            //left - right
            let enemy = lev1Enemies[i]
            enemy.position.x = enemy.position.x + 10
            if (enemy.position.x > self.frame.width){
                enemy.position.x = 0
            }
            
        }
        
        for i in 0..<lev2Enemies.count {
            //left - right
            let enemy = lev2Enemies[i]
            enemy.position.x = enemy.position.x + 10
            if (enemy.position.x > self.frame.width){
                enemy.position.x = 0
            }
            
        }
        
        for i in 0..<lev3Enemies.count {
            //left - right
            let enemy = lev3Enemies[i]
            enemy.position.x = enemy.position.x + 10
            if (enemy.position.x > self.frame.width){
                enemy.position.x = 0
            }
            
        }
        
        if (timeOfLastUpdate == nil) {
            timeOfLastUpdate = currentTime
        }
        // print a message every 3 seconds
        var timePassed = (currentTime - timeOfLastUpdate!)
        if (timePassed >= 3.5) {
            if(lev1Enemies.count <= 5 )
            {
                print("HERE IS A MESSAGE!")
                timeOfLastUpdate = currentTime
                // make a cat
                self.makeEnemies()
            }
            if(lev2Enemies.count <= 5 )
            {
                print("HERE IS A MESSAGE!")
                timeOfLastUpdate = currentTime
                // make a cat
                self.makeEnemies()
            }
            
            if(lev3Enemies.count <= 5 )
            {
                print("HERE IS A MESSAGE!")
                timeOfLastUpdate = currentTime
                // make a cat
                self.makeEnemies()
            }
        }
        
        if (timePassed >= 0.5){
            if (playerDir != "left" || playerDir != "right"){
                playerDir = "no movement"
            }
        }
        
    }
    
    
    func makeEnemies() {
        
        let enemy = SKSpriteNode(imageNamed: "enemy")
        let enemy1 = SKSpriteNode(imageNamed: "enemy")
        let enemy2 = SKSpriteNode(imageNamed: "enemy")
        
        //level 1
        let randX = Int(level1.position.x - 70)
        let randY = Int(level1.position.y + 70)
        enemy.position = CGPoint(x:randX, y:randY)
        print("enemy position \(randX) \(randY)")
        
        
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        enemy.physicsBody?.isDynamic = true
        enemy.physicsBody?.affectedByGravity = false
        enemy.physicsBody?.allowsRotation = false
        
        // give him a category
        enemy.physicsBody?.categoryBitMask = 2
        enemy.physicsBody?.contactTestBitMask = 1
        
        enemy.physicsBody?.collisionBitMask = 0
        enemy.name = "enemy"
        
        addChild(enemy)
        self.lev1Enemies.append(enemy)
        
        
        // level 2
        let randX1 = Int(level2.position.x )
        let randY1 = Int(level2.position.y + 70)
        enemy1.position = CGPoint(x:randX1, y:randY1)
        print("enemy position \(randX1) \(randY1)")
        
        // setup physics for each cat
        enemy1.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        enemy1.physicsBody?.isDynamic = true
        enemy1.physicsBody?.affectedByGravity = false
        enemy1.physicsBody?.allowsRotation = false
        
        // give him a category
        enemy1.physicsBody?.categoryBitMask = 2
        enemy1.physicsBody?.contactTestBitMask = 1
        
        
        enemy1.physicsBody?.collisionBitMask = 0
        enemy1.name = "enemy"
        addChild(enemy1)
        // add enemy to level 1 array
        self.lev2Enemies.append(enemy1)
        
            // level 3
        let randX2 = Int(level3.position.x )
        let randY2 = Int(level3.position.y + 70)
        enemy2.position = CGPoint(x:randX2, y:randY2)
        print("enemy position \(randX2) \(randX2)")
        
        // setup physics for each cat
        enemy2.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        enemy2.physicsBody?.isDynamic = true
        enemy2.physicsBody?.affectedByGravity = false
        enemy2.physicsBody?.allowsRotation = false
        
        // give him a category
        enemy2.physicsBody?.categoryBitMask = 2
        enemy2.physicsBody?.contactTestBitMask = 1
        
        
        enemy2.physicsBody?.collisionBitMask = 0
        enemy2.name = "enemy"
        addChild(enemy2)
        // add enemy to level 1 array
        self.lev3Enemies.append(enemy2)
        
    }
    
}
