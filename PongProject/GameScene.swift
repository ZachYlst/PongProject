//
//  GameScene.swift
//  PongProject
//
//  Created by Ylst, Zachary on 3/7/18.
//  Copyright © 2018 CTEC. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene
{
    var player = SKSpriteNode()
    var opponent = SKSpriteNode()
    var ball = SKSpriteNode()
    
    override func didMove(to view: SKView)
    {
        player = self.childNode(withName: "player") as! SKSpriteNode
        opponent = self.childNode(withName: "opponent") as! SKSpriteNode
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 30, dy: 30))
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
    }
    
    override func touchesBegan(
    
    override func update(_ currentTime: TimeInterval)
    {
        if (ball.yPos < player.xPos)
        {
            ball.
        }
    }
}
