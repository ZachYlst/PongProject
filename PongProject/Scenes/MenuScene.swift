//
//  MenuScene.swift
//  PongProject
//
//  Created by Ylst, Zachary on 3/20/18.
//  Copyright © 2018 CTEC. All rights reserved.
//

import SpriteKit
import GameplayKit

public class MenuScene: SKScene
{
    var easyLabel = SKLabelNode()
    var mediumLabel = SKLabelNode()
    var hardLabel = SKLabelNode()
    var pongLabel = SKLabelNode()
    var nameLabel = SKLabelNode()
    var startLabel = SKLabelNode()
    
    var menuBall = SKSpriteNode()
    var easyButton = SKSpriteNode()
    var mediumButton = SKSpriteNode()
    var hardButton = SKSpriteNode()
    
    override public func didMove(to View: SKView)
    {
        easyLabel = self.childNode(withName: "easyLabel") as! SKLabelNode
        mediumLabel = self.childNode(withName: "mediumLabel") as! SKLabelNode
        hardLabel = self.childNode(withName: "hardLabel") as! SKLabelNode
        pongLabel = self.childNode(withName: "pongLabel") as! SKLabelNode
        nameLabel = self.childNode(withName: "nameLabel") as! SKLabelNode
        startLabel = self.childNode(withName: "startLabel") as! SKLabelNode
        
        menuBall = self.childNode(withName: "menuBall") as! SKSpriteNode
        easyButton = self.childNode(withName: "easyButton") as! SKSpriteNode
        mediumButton = self.childNode(withName: "mediumButton") as! SKSpriteNode
        hardButton = self.childNode(withName: "hardButton") as! SKSpriteNode
        
        menuBall.physicsBody?.applyImpulse(CGVector(dx: 40.0, dy: 40.0))
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
    }
}
