//
//  GameScene.swift
//  PongProject
//
//  Created by Ylst, Zachary on 3/7/18.
//  Copyright © 2018 CTEC. All rights reserved.
//

import SpriteKit
import GameplayKit

// The primary scene where the game commences
class GameScene: SKScene, SKPhysicsContactDelegate
{
    var exitCode: Int = 0
    var score = [Int]()
    
    var player = SKSpriteNode()
    var opponent = SKSpriteNode()
    var ball = SKSpriteNode()
    var playerScore = SKLabelNode()
    var opponentScore = SKLabelNode()
    var bumper = SKSpriteNode()
    
    var pausedLabel = SKLabelNode()
    var pausedBackground = SKSpriteNode()
    
    var easyButton = SKSpriteNode()
    var mediumButton = SKSpriteNode()
    var hardButton = SKSpriteNode()
    
    // Called imediately after the scene is called by the view
    override func didMove(to view: SKView)
    {
        startGame()
        
        self.physicsWorld.contactDelegate = self
        
        player = self.childNode(withName: "player") as! SKSpriteNode
        opponent = self.childNode(withName: "opponent") as! SKSpriteNode
        playerScore = self.childNode(withName: "playerScore") as! SKLabelNode
        opponentScore = self.childNode(withName: "opponentScore") as! SKLabelNode
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        ball.physicsBody?.usesPreciseCollisionDetection = true
        bumper = self.childNode(withName: "bumper") as! SKSpriteNode
        bumper.physicsBody?.usesPreciseCollisionDetection = true
        
        pausedLabel = self.childNode(withName: "pausedLabel") as! SKLabelNode
        pausedLabel.isHidden = true
        pausedBackground = self.childNode(withName: "pausedBackground") as! SKSpriteNode
        pausedBackground.isHidden = true
        
        easyButton = self.childNode(withName: "easyButton") as! SKSpriteNode
        easyButton.isUserInteractionEnabled = true
        mediumButton = self.childNode(withName: "mediumButton") as! SKSpriteNode
        mediumButton.isUserInteractionEnabled = true
        hardButton = self.childNode(withName: "hardButton") as! SKSpriteNode
        hardButton.isUserInteractionEnabled = true
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 40, dy: 40))
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
    }
    
    // Called to initialize the game with a default score
    func startGame()
    {
        score = [0,0]
    }
    
    // Called when either player scores a point
    func addScore(playerWhoWon: SKSpriteNode)
    {
        ball.physicsBody?.velocity = CGVector(dx:0, dy: 0)
        ball.position = CGPoint(x: 0.0, y: 0.0)
        
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
            }
        }
    }
    
    // Called when a touch is detected in the view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view?.isPaused = false
        pausedLabel.isHidden = true
        pausedBackground.isHidden = true
        
        for touch in touches
        {
            let location = touch.location(in: self)
            
            player.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
       
    }
    
    // Called when the location of a touch changes
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            let location = touch.location(in: self)
            
            player.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    // Called when the user's finger is removed from the scene
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view?.isPaused = true
        pausedLabel.isHidden = false
        pausedBackground.isHidden = false
    }
    
    // Called every frame the scene is active
    override func update(_ currentTime: TimeInterval)
    {
        opponent.run(SKAction.moveTo(x: ball.position.x, duration: 0.3))
        
        if ball.position.y <= player.position.y - 100
        {
            addScore(playerWhoWon: opponent)
        }
        else if ball.position.y >= opponent.position.y + 100
        {
            addScore(playerWhoWon: player)
        }
    }
    
    // Called when 2+ physicsBodies collide
//    func didBegin(_ contact: SKPhysicsContact)
//    {
//        if (contact.bodyA.node?.name == "bumper" && contact.bodyB.node?.name == "ball")
//        {
//            print("Ball/Bumper collided")
//            ball.physicsBody?.applyImpulse(CGVector(dx:, dy:))
//        }
//    }
    
    enum Difficulty
    {
        case easy
        case medium
        case hard
    }
}
