//
//  helpScene.swift
//  firstGame
//
//  Created by Max DeVos on 4/1/16.
//  Copyright © 2016 Max DeVos. All rights reserved.
//

import SpriteKit

class HelpScene: SKScene {
    
    let stars = SKSpriteNode(imageNamed: "stars")
    let helpInfo = SKSpriteNode(imageNamed: "helpInfo")
    
    override func didMoveToView(view: SKView) {
        //stars
        stars.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        stars.zPosition = -1.0
        stars.yScale = 2
        stars.xScale = 2
        
        helpInfo.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        self.addChild(stars)
        self.addChild(helpInfo)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let scene = GameScene(size: self.size)
        let skView = self.view as SKView!
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
        scene.size = skView.bounds.size
        skView.presentScene(scene)
        
    }
    
}