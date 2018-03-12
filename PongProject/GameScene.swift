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
    var exitCode: Int = 0
    var score = [Int]()
    
    var player = SKSpriteNode()
    var opponent = SKSpriteNode()
    var ball = SKSpriteNode()
    var playerScore = SKLabelNode()
    var opponentScore = SKLabelNode()
    var leftBumper = SKSpriteNode()
    var rightBumper = SKSpriteNode()
    
    override func didMove(to view: SKView)
    {
        startGame()
        
        player = self.childNode(withName: "player") as! SKSpriteNode
        opponent = self.childNode(withName: "opponent") as! SKSpriteNode
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        playerScore = self.childNode(withName: "playerScore") as! SKLabelNode
        opponentScore = self.childNode(withName: "opponentScore") as! SKLabelNode
        leftBumper = self.childNode(withName: "leftBumper") as! SKSpriteNode
        rightBumper = self.childNode(withName: "rightBumper") as! SKSpriteNode
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 40, dy: 40))
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
    }
    
    func startGame()
    {
        score = [0,0]
    }
    
    func addScore(playerWhoWon: SKSpriteNode)
    {
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx:0, dy: 0)
        
        let transition = SKTransition.reveal(with: .down, duration: 1.0)
        let nextScene = GameOverScene(size: (scene?.size)!)
        nextScene.scaleMode = .aspectFill
        
        if playerWhoWon == player
        {
            score[0] += 1
            playerScore.text = String("\(score[0])")
            ball.physicsBody?.applyImpulse(CGVector(dx: 40, dy: 40))
            if (score[0] > 10)
            {
                exitCode = 1
                scene?.view?.presentScene(nextScene, transition: transition)
            }
        }
        else if playerWhoWon == opponent
        {
            score[1] += 1
            opponentScore.text = String("\(score[1])")
            ball.physicsBody?.applyImpulse(CGVector(dx: -40, dy: -40))
            if (score[1] > 10)
            {
                exitCode = 2
                scene?.view?.presentScene(nextScene, transition: transition)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            let location = touch.location(in: self)
            
            player.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            let location = touch.location(in: self)
            
            player.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        opponent.run(SKAction.moveTo(x: ball.position.x, duration: 0.2))
        
        if ball.position.y <= player.position.y - 100
        {
            addScore(playerWhoWon: opponent)
        }
        else if ball.position.y >= opponent.position.y + 100
        {
            addScore(playerWhoWon: player)
        }
        
        
        
//        let circle = UIBezierPath(roundedRect: CGRect(x: leftBumper.position.x, y: leftBumper.position.y, width: 5, height: 5), cornerRadius: 5)
//
//        let followCircle = SKAction.follow(circle.cgPath, asOffset: true, orientToPath: false, duration: 2.0)
//
//        leftBumper.run(SKAction.sequence([followCircle]))
//        rightBumper.run(SKAction.sequence([followCircle]))
    }
}
