//
//  GameOverScene.swift
//  PongProject
//
//  Created by Ylst, Zachary on 3/12/18.
//  Copyright © 2018 CTEC. All rights reserved.
//

import SpriteKit
import GameplayKit

public class GameOverScene: SKScene
{
    var winnerLabel = SKLabelNode()
    var exitedCode = GameScene()
    
    override public func didMove(to view: SKView)
    {
        winnerLabel = self.childNode(withName: "winnerLabel") as! SKLabelNode
        
        if (exitedCode.exitCode == 1)
        {
            winnerLabel.text = String("Player Won!!")
        }
        else if (exitedCode.exitCode == 2)
        {
            winnerLabel.text = String("Opponent Won!!")
        }
    }
}
