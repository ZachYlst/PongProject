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
public class GameScene: SKScene, SKPhysicsContactDelegate
{
//    var pongLabel = MenuScene()
    var difficultyCode: Int = 0
    
    var player = SKSpriteNode()
    var opponent = SKSpriteNode()
    var ball = SKSpriteNode()
    
    var score = [Int]()
    var playerScore = SKLabelNode()
    var opponentScore = SKLabelNode()
    
    var items: [String] = ["gravity", "grow", "speed"]
    var durationBar = SKSpriteNode()
    var durationBarBackground = SKSpriteNode()
    var linearGravity = SKFieldNode()
    
    // Called imediately after the scene is called by the view
    override public func didMove(to view: SKView)
    {
        startGame()
        
        self.physicsWorld.contactDelegate = self
        
        player = self.childNode(withName: "player") as! SKSpriteNode
        opponent = self.childNode(withName: "opponent") as! SKSpriteNode
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        ball.physicsBody?.usesPreciseCollisionDetection = true
        
        playerScore = self.childNode(withName: "playerScore") as! SKLabelNode
        opponentScore = self.childNode(withName: "opponentScore") as! SKLabelNode
        
        durationBar = self.childNode(withName: "durationBar") as! SKSpriteNode
        durationBar.isHidden = true
        durationBarBackground = self.childNode(withName: "durationBarBackground") as! SKSpriteNode
        durationBarBackground.isHidden = true
        linearGravity = self.childNode(withName: "linearGravity") as! SKFieldNode
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 40, dy: 40))
        
        self.backgroundColor = UIColor.black
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
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        ball.position = CGPoint(x: 0.0, y: 0.0)
        
        if playerWhoWon == player
        {
            score[0] += 1
            playerScore.text = String("\(score[0])")
            ball.physicsBody?.applyImpulse(CGVector(dx: 40, dy: 40))
//            if (score[0] > 10)
//            {
//                pongLabel.pongLabel.text = "Player Wins!!"
//                if let view = self.view
//                {
//                    if let scene = SKScene(fileNamed: "MenuScene")
//                    {
//                        scene.scaleMode = .aspectFill
//                        view.presentScene(scene)
//                    }
//                    view.ignoresSiblingOrder = true
//                    view.showsFPS = true
//                    view.showsNodeCount = true
//                }
//            }
        }
        else if playerWhoWon == opponent
        {
            score[1] += 1
            opponentScore.text = String("\(score[1])")
            ball.physicsBody?.applyImpulse(CGVector(dx: -40, dy: -40))
//            if (score[1] > 10)
//            {
//                pongLabel.pongLabel.text = "Opponent Wins!!"
//                if let view = self.view
//                {
//                    if let scene = SKScene(fileNamed: "MenuScene")
//                    {
//                        scene.scaleMode = .aspectFill
//                        view.presentScene(scene)
//                    }
//                    view.ignoresSiblingOrder = true
//                    view.showsFPS = true
//                    view.showsNodeCount = true
//                }
//            }
        }
    }
    
    // Called when the item duration has elapsed
    func cancelItem()
    {
        self.backgroundColor = UIColor.black
        linearGravity.strength = 0
        player.size.width = 250
        opponent.size.width = 250
        ball.speed = 1.0
    }
    
    // Called when a touch is detected in the view
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view?.isPaused = false
        
        for touch in touches
        {
            let location = touch.location(in: self)
            
            player.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    // Called when the location of a touch changes
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            let location = touch.location(in: self)
            
            player.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    // Called when the user's finger is removed from the scene
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view?.isPaused = true
    }
    
    // Called every frame the scene is active
    override public func update(_ currentTime: TimeInterval)
    {
        let randomItem = Int(arc4random_uniform(UInt32(items.count)))
        let selectedItem = items[randomItem]
        
        let durationBarShrink = SKAction.resize(toWidth: 0,
               height: durationBar.size.height,
               duration: 5.0)
        
        let blue = SKColor(red: 0, green: 0, blue: 0.1, alpha: 1)
        let green = SKColor(red: 0, green: 0.1, blue: 0, alpha: 1)
        let red = SKColor(red: 0.1, green: 0, blue: 0, alpha: 1)
        
//        switch difficultyCode
//        {
//        case 1:
//            opponent.run(SKAction.moveTo(x: ball.position.x, duration: 0.7))
//        case 2:
//            opponent.run(SKAction.moveTo(x: ball.position.x, duration: 0.5))
//        case 3:
//            opponent.run(SKAction.moveTo(x: ball.position.x, duration: 0.3))
//        default:
//            break
//        }
        
        opponent.run(SKAction.moveTo(x: ball.position.x, duration: 0.3))

        if ball.position.y <= player.position.y - 80
        {
            addScore(playerWhoWon: opponent)
            if (self.backgroundColor != blue && self.backgroundColor != green && self.backgroundColor != red)
            {
                switch selectedItem
                {
                case "gravity":
                    self.backgroundColor = blue
                    durationBar.color = UIColor.blue
                    linearGravity.strength = 10
                    durationBar.isHidden = false
                    durationBarBackground.isHidden = false
                    durationBar.run(durationBarShrink)
                case "grow":
                    self.backgroundColor = green
                    durationBar.color = UIColor.green
                    player.size.width = 400
                    durationBar.isHidden = false
                    durationBarBackground.isHidden = false
                    durationBar.run(durationBarShrink)
                case "speed":
                    self.backgroundColor = red
                    durationBar.color = UIColor.red
                    ball.speed = 2.0
                    durationBar.isHidden = false
                    durationBarBackground.isHidden = false
                    durationBar.run(durationBarShrink)
                default:
                    break
                }
            }
        }
        else if ball.position.y >= opponent.position.y + 80
        {
            addScore(playerWhoWon: player)
            if (self.backgroundColor != blue && self.backgroundColor != green && self.backgroundColor != red)
            {
                switch selectedItem
                {
                case "gravity":
                    self.backgroundColor = blue
                    durationBar.color = UIColor.blue
                    linearGravity.strength = -10
                    durationBar.isHidden = false
                    durationBarBackground.isHidden = false
                    durationBar.run(durationBarShrink)
                case "grow":
                    self.backgroundColor = green
                    durationBar.color = UIColor.green
                    opponent.size.width = 400
                    durationBar.isHidden = false
                    durationBarBackground.isHidden = false
                    durationBar.run(durationBarShrink)
                case "speed":
                    self.backgroundColor = red
                    durationBar.color = UIColor.red
                    ball.speed = 2.0
                    durationBar.isHidden = false
                    durationBarBackground.isHidden = false
                    durationBar.run(durationBarShrink)
                default:
                    break
                }
            }
        }
        
        if (durationBar.size.width == 0)
        {
            durationBar.size.width = 750
            durationBar.isHidden = true
            durationBarBackground.size.width = 750
            durationBarBackground.isHidden = true
            cancelItem()
        }
    }
}
