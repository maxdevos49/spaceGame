//
//  playscene.swift
//  firstGame
//
//  Created by Max DeVos on 4/1/16.
//  Copyright © 2016 Max DeVos. All rights reserved.
//

import SpriteKit
import Foundation

class PlayScene: SKScene {

    //add some sprites
    let spaceShip = SKSpriteNode(imageNamed: "spaceship")
    let stars = SKSpriteNode(imageNamed: "stars")
    let pauseButt = SKSpriteNode(imageNamed: "pauseButt")
    let healthBar = SKSpriteNode(imageNamed: "healthBar")
    let pauseButtGui = SKSpriteNode(imageNamed: "pauseButtGui")
    let pauseButt1 = SKSpriteNode(imageNamed: "pauseButt1")
    let joyStickRing = SKSpriteNode(imageNamed: "joystickring")
    let joyStickToggle = SKSpriteNode(imageNamed: "joysticktoggle")
    let fireButton = SKSpriteNode(imageNamed: "fireButton")
    let ammoCountText = SKLabelNode(text: "5")
    let healthBarLevel = SKShapeNode(rectOfSize: CGSize(width: 310, height: 20))
    let alienSprite = [SKSpriteNode(imageNamed: "alien"), SKSpriteNode(imageNamed: "alien"), SKSpriteNode(imageNamed: "alien"), SKSpriteNode(imageNamed: "alien"), SKSpriteNode(imageNamed: "alien")]
    let missleSprites = [SKSpriteNode(imageNamed: "laserBolts"),SKSpriteNode(imageNamed: "laserBolts"),SKSpriteNode(imageNamed: "laserBolts"),SKSpriteNode(imageNamed: "laserBolts"),SKSpriteNode(imageNamed: "laserBolts")]
    
    var play:Bool = true
    let friction:CGFloat = 0.3
    var move:String = "false"
    var targetY:CGFloat = 0.0
    var targetX:CGFloat = 0.0
    var fricX:CGFloat = 0.0
    var fricY:CGFloat = 0.0
    var velX:CGFloat = 0
    var velY:CGFloat = 0
    var joyStickX:CGFloat = 0.0
    var joyStickY:CGFloat = 0.0
    
    //missle varibles
    var missleMode = [0,0,0,0,0]
    var missleVelX:[CGFloat] = [0.0,0.0,0.0,0.0,0.0]
    var missleVelY:[CGFloat] = [0.0,0.0,0.0,0.0,0.0]
    var currentMissle = 0
    var ammoCount = 5
    
    //alien variables
    var alienMode = [1,0,0,0,0]
    var alienVelX:[CGFloat] = [0.0,0.0,0.0,0.0,0.0]
    var alienVelY:[CGFloat] = [0.0,0.0,0.0,0.0,0.0]
    var alienSpeed:CGFloat  = 2
    var currentAlien = 0
    var alienCount = 5
    
    
    override func didMoveToView(view: SKView) {
        //set up screen
        self.backgroundColor = UIColor.blackColor()
        
        //stars
        stars.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        stars.zPosition = -1.0
        stars.yScale = 2
        stars.xScale = 2
        
        //spaceship
        spaceShip.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        spaceShip.zPosition = -0.5
        
        //pauseButt
        pauseButt.position = CGPoint(x:CGRectGetMinX(self.frame) + pauseButt.size.width/2, y:CGRectGetMaxY(self.frame) - pauseButt.size.height/2)
        pauseButt.alpha = 0.75
        
        //health bar
        healthBar.position = CGPoint(x:CGRectGetMaxX(self.frame) - healthBar.size.width/2 - 5, y:CGRectGetMaxY(self.frame) - healthBar.size.height/2 - 5)
        healthBar.zPosition = 0.75
        
        //health bar level
        healthBarLevel.fillColor = SKColor.redColor()
        healthBarLevel.position = CGPoint(x: CGRectGetMaxX(self.frame) - 273, y: CGRectGetMaxY(self.frame) - 52)
        healthBarLevel.zPosition = 0.76
        
        //ammoCount Text
        ammoCountText.position = CGPoint(x:CGRectGetMaxX(self.frame) - 55, y:CGRectGetMaxY(self.frame) - 67)
        ammoCountText.zPosition = 1.0
        
        //joy stick ring
        joyStickRing.xScale = 0.5
        joyStickRing.yScale = 0.5
        joyStickRing.alpha = 0.75
        joyStickRing.position = CGPoint(x:CGRectGetMinX(self.frame) + joyStickRing.size.width/2 + 10, y:CGRectGetMinY(self.frame) + joyStickRing.size.height/2 + 10)
        
        //joy stick toggle
        joyStickToggle.xScale = 0.5
        joyStickToggle.yScale = 0.5
        joyStickToggle.alpha = 0.75
        joyStickToggle.position = CGPoint(x:CGRectGetMinX(self.frame) + joyStickRing.size.width/2 + 14, y:CGRectGetMinY(self.frame) + joyStickRing.size.height/2 + 10)
        joyStickX = joyStickToggle.position.x
        joyStickY = joyStickToggle.position.y
        
        //firebutton
        fireButton.xScale = 0.5
        fireButton.yScale = 0.5
        fireButton.position = CGPoint(x:CGRectGetMaxX(self.frame) - fireButton.size.width/2 - 10, y:CGRectGetMinY(self.frame) + fireButton.size.height/2 + 10)
        
        //alien
        alienSprite[0].position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        self.addChild(alienSprite[0])
        self.addChild(healthBarLevel)
        self.addChild(ammoCountText)
        self.addChild(fireButton)
        self.addChild(joyStickToggle)
        self.addChild(joyStickRing)
        self.addChild(healthBar)
        self.addChild(stars)
        self.addChild(spaceShip)
        self.addChild(pauseButt)

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if play == true{
            for touch: AnyObject in touches {
                let location = touch.locationInNode(self)
                
                if self.nodeAtPoint(location) == self.joyStickRing {
                    self.targetX = location.x
                    self.targetY = location.y
                    joyStickToggle.position.x = location.x
                    joyStickToggle.position.y = location.y
                    move = "true"
                }
            }
        }
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            //make button look press
            if self.nodeAtPoint(location) == self.pauseButt {
                pauseButt.alpha = 0.5
            }else if self.nodeAtPoint(location) == self.fireButton {
                fireButton.alpha = 0.5
                fireBolt()
            }
            
            
        }
        
    }// end touches began
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if play == true{
            for touch: AnyObject in touches {
                let location = touch.locationInNode(self)
                if self.nodeAtPoint(location) == self.joyStickRing {
                    self.targetX = location.x
                    self.targetY = location.y
                    joyStickToggle.position.x = location.x
                    joyStickToggle.position.y = location.y
                    move = "true"
                }else{
                    joyStickToggle.position.x = joyStickX
                    joyStickToggle.position.y = joyStickY
                    move = "decel"
                }
            }
        }
        
        
    }//end touches moved
    
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            if play == true {
                joyStickToggle.position.x = joyStickX
                joyStickToggle.position.y = joyStickY
                move = "decel"
            }
            
            //make button look press
            if self.nodeAtPoint(location) == self.pauseButt {
                if play == true {
                    play = false
                    pauseButt.alpha = 1.0
                    
                    pauseButtGui.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
                    pauseButtGui.alpha = 0.75
                    
                    pauseButt1.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + pauseButt1.size.height * 1.5)
                    pauseButt1.zPosition = 1.0
                    
                    self.addChild(pauseButt1)
                    self.addChild(pauseButtGui)
                    
                    
                    
                }else if play == false{//
                    play = true
                    pauseButt1.removeFromParent()
                    pauseButtGui.removeFromParent()
                }
            }else if self.nodeAtPoint(location) == self.fireButton {
                fireButton.alpha = 1.0
                
                
            }else{
                pauseButt.alpha = 1.0
                fireButton.alpha = 1.0
            }
            
            if self.nodeAtPoint(location) == self.pauseButt1 {
                
                play = false
                 let scene = GameScene(size: self.size)
                 let skView = self.view as SKView!
                 skView.ignoresSiblingOrder = true
                 scene.scaleMode = .ResizeFill
                 scene.size = skView.bounds.size
                 skView.presentScene(scene)
 
                
            }
            
            
        }
        
    }//end touches ended
    
    func moveShip(){
        
        
        if move == "true"{
            // Get sprite's current position (a.k.a. starting point).
            let currentPosition = joyStickRing.position
            
            // Calculate the angle using the relative positions of the sprite and touch.
            let angle = atan2(currentPosition.y - targetY, currentPosition.x - targetX)
            
            // Define actions for the ship to take.
            let rotateAction = SKAction.rotateToAngle(angle - CGFloat(M_PI*0.5), duration: 0.0)
            
            velX = (currentPosition.x - targetX)/5
            
            velY = (currentPosition.y - targetY)/5
            
            stars.position.x = stars.position.x + velX
            stars.position.y = stars.position.y + velY
            
            //translate missles
            if ammoCount < 5 {
                translateMissles()
            }
            
            // Tell the ship to execute actions.
            spaceShip.runAction(SKAction.sequence([rotateAction]))
        }else if move == "decel"{
            
            if velX > 0 {
                velX = velX + -friction
            }else{
                velX = velX + friction
            }
            
            if velY > 0 {
                velY = velY + -friction
            }else{
                velY = velY + friction
            }
            
            stars.position.x = stars.position.x + velX
            stars.position.y = stars.position.y + velY
            
            //translate missles
            if ammoCount < 5 {
                translateMissles()
            }

        }

    }//end move ship func
    
    func translateMissles(){
        
        for index in 0...4{
            
            if missleMode[index] == 1{
                
                missleSprites[index].position.x = missleSprites[index].position.x + velX
                missleSprites[index].position.y = missleSprites[index].position.y + velY
                
            }
            
        }
        
    }//end of translate missles
    
    func fireBolt(){
        
        if missleMode[currentMissle] == 0{
        
        //add missle
        missleSprites[currentMissle].position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        // Get sprite's angle needed
        let currentPosition = joyStickRing.position
        
        // Calculate the angle using the relative positions of the sprite and touch.
        let angle = atan2(currentPosition.y - targetY, currentPosition.x - targetX)
        
        // Define actions for the ship to take.
        let rotateAction = SKAction.rotateToAngle(angle + CGFloat(M_PI * 0.5), duration: 0.0)
        
        missleVelX[currentMissle] = (currentPosition.x - targetX)/5
            
        missleVelY[currentMissle] = (currentPosition.y - targetY)/5
            
        //rotate missle to correct orientation
        missleSprites[currentMissle].runAction(SKAction.sequence([rotateAction]))
        
        //add missle to screen
        self.addChild(missleSprites[currentMissle])
        missleMode[currentMissle] = 1
        ammoCount = ammoCount - 1
        ammoCountText.text = String(ammoCount)
        
        //increment missle to add next
        currentMissle = currentMissle + 1
        if currentMissle > 4 {
            currentMissle = 0
        }
    }
        
    }//end misslefire
    
    func moveMissle(){
        for index in 0...4{
            
            if missleMode[index] == 1{
                
                missleSprites[index].position.x = missleSprites[index].position.x + -missleVelX[index]
                missleSprites[index].position.y = missleSprites[index].position.y + -missleVelY[index]

                if missleSprites[index].position.x < 0 || missleSprites[index].position.x > CGRectGetMaxX(self.frame) || missleSprites[index].position.y < 0 || missleSprites[index].position.y > CGRectGetMaxY(self.frame){
                missleSprites[index].removeFromParent()
                missleMode[index] = 0
                ammoCount = ammoCount + 1
                ammoCountText.text = String(ammoCount)
                }
            }
            
        }
    }//end missle move
    
    func moveAlien(){
        for index in 0...4{
            
            if alienMode[index] == 1{
                let distance = spaceShip.position.distanceFromCGPoint(alienSprite[0].position)
                
                let angle = atan2(alienSprite[index].position.y - spaceShip.position.y, alienSprite[index].position.x - spaceShip.position.x)
                
                // Define actions for the ship to take.
                let rotateAction = SKAction.rotateToAngle(angle + CGFloat(M_PI * 0.25), duration: 0.0)
                
                alienSprite[index].runAction(SKAction.sequence([rotateAction]))
                
                if distance > 200 {//if its far
                    if spaceShip.position.x > alienSprite[index].position.x{
                        alienVelX[index] = 2 * alienSpeed
                    }else{
                        alienVelX[index] = 2 * -alienSpeed
                    }
                    
                    if spaceShip.position.y > alienSprite[index].position.y{
                        alienVelY[index] = 2 * alienSpeed
                    }else{
                        alienVelY[index] = 2 * -alienSpeed
                    }
                    
                }else{//if its close
                    
                    if spaceShip.position.x > alienSprite[index].position.x{
                        alienVelX[index] = alienSpeed
                    }else{
                        alienVelX[index] = -alienSpeed
                    }
                    
                    if spaceShip.position.y > alienSprite[index].position.y{
                        alienVelY[index] = alienSpeed
                    }else{
                        alienVelY[index] = -alienSpeed
                    }
                    
                }
                alienSprite[index].position.x = alienSprite[index].position.x + velX + alienVelX[index]
                alienSprite[index].position.y = alienSprite[index].position.y + velY + alienVelY[index]
                
                for index2 in 0...4{
                    let collisionCheck = alienSprite[index].position.distanceFromCGPoint(missleSprites[index2].position)
                    if missleMode[index2] == 1 {
                        if collisionCheck < 30 {
                            missleSprites[index2].removeFromParent()
                            alienSprite[index].removeFromParent()
                            alienMode[index] = 0
                            missleMode[index2] = 0
                            ammoCount = ammoCount + 1
                            ammoCountText.text = String(ammoCount)
                        }
                    }
                    
                }
            }
        }
    }//end moveAlien
    
    override func update(currentTime: NSTimeInterval) {
  
        if play == true {
            moveShip()
            moveAlien()
            moveMissle()
        }
    }
    
}


extension CGPoint {
    func distanceFromCGPoint(point:CGPoint)->CGFloat{
        return sqrt(pow(self.x - point.x,2) + pow(self.y - point.y,2))
    }
}

