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
    var difficultyCoder = GameScene()
    
    var easyLabel = SKLabelNode()
    var mediumLabel = SKLabelNode()
    var hardLabel = SKLabelNode()
    var pongLabel = SKLabelNode()
    var nameLabel = SKLabelNode()
    var startLabel = SKLabelNode()
    
    var easyButton = SKSpriteNode()
    var mediumButton = SKSpriteNode()
    var hardButton = SKSpriteNode()
    
    override public func didMove(to View: SKView)
    {
        easyLabel = self.childNode(withName: "easyLabel") as! SKLabelNode
        easyLabel.isUserInteractionEnabled = false
        mediumLabel = self.childNode(withName: "mediumLabel") as! SKLabelNode
        mediumLabel.isUserInteractionEnabled = false
        hardLabel = self.childNode(withName: "hardLabel") as! SKLabelNode
        hardLabel.isUserInteractionEnabled = false
        pongLabel = self.childNode(withName: "pongLabel") as! SKLabelNode
        nameLabel = self.childNode(withName: "nameLabel") as! SKLabelNode
        startLabel = self.childNode(withName: "startLabel") as! SKLabelNode
        
        easyButton = self.childNode(withName: "easyButton") as! SKSpriteNode
        mediumButton = self.childNode(withName: "mediumButton") as! SKSpriteNode
        hardButton = self.childNode(withName: "hardButton") as! SKSpriteNode
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            let transition = SKTransition.fade(withDuration: 1)
            let scene = SKScene(fileNamed: "GameScene")
            
            let location = touch.location(in: self)
            let nodeAtLocation = self.atPoint(location)
            switch nodeAtLocation.name
            {
            case "easyButton"?:
                difficultyCoder.difficultyCode = 1
                self.view?.presentScene(scene!, transition: transition)
            case "mediumButton"?:
                difficultyCoder.difficultyCode = 2
                self.view?.presentScene(scene!, transition: transition)
            case "hardButton"?:
                difficultyCoder.difficultyCode = 3
                self.view?.presentScene(scene!, transition: transition)
            default:
                break
            }
        }
    }
}
