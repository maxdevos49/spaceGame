//
//  GameScene.swift
//  firstGame
//
//  Created by Max DeVos on 4/1/16.
//  Copyright (c) 2016 Max DeVos. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    
    //initialize things here
    let mainMenu = SKSpriteNode(imageNamed: "mainMenu")
    let playButt = SKSpriteNode(imageNamed: "play")
    let helpButt = SKSpriteNode(imageNamed: "help")
    let stars = SKSpriteNode(imageNamed: "stars")
    
    override func didMoveToView(view: SKView) {
        
        //position things here// figure out z index
        //stars
        stars.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        stars.zPosition = -1.0
        stars.yScale = 2
        stars.xScale = 2
        
        mainMenu.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        playButt.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + 50)
        helpButt.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) - 100)
        //make sure they are on correct layer
        mainMenu.zPosition = -0.75
        playButt.zPosition = 1.0
        helpButt.zPosition = 1.0
        
        self.addChild(stars)
        self.addChild(mainMenu)
        self.addChild(playButt)
        self.addChild(helpButt)
    }
    
    /*
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!"
        myLabel.fontSize = 45
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        self.addChild(myLabel)
    }
    */
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            //make button look press
            if self.nodeAtPoint(location) == self.playButt {
                playButt.alpha = 0.5
            }
            //make button look pressed
            if self.nodeAtPoint(location) == self.helpButt {
                helpButt.alpha = 0.5
            }
        }
    }
   
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            //make button look press
            if self.nodeAtPoint(location) == self.playButt {
                //play game here
                playButt.alpha = 1.0
                
                let scene = PlayScene(size: self.size)
                let skView = self.view as SKView!
                skView.ignoresSiblingOrder = true
                scene.scaleMode = .ResizeFill
                scene.size = skView.bounds.size
                skView.presentScene(scene)
                
            }else{
                playButt.alpha = 1.0
            }
            //make button look pressed
            if self.nodeAtPoint(location) == self.helpButt {
                //show help here
                helpButt.alpha = 1.0
                
                let scene = HelpScene(size: self.size)
                let skView = self.view as SKView!
                skView.ignoresSiblingOrder = true
                scene.scaleMode = .ResizeFill
                scene.size = skView.bounds.size
                skView.presentScene(scene)
                
            }else{
                helpButt.alpha = 1.0
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
