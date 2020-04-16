//
//  GameScene.swift
//  DiveIntoSpriteKit
//
//  Created by Paul Hudson on 16/10/2017.
//  Copyright © 2017 Paul Hudson. All rights reserved.
//

import SpriteKit

@objcMembers
class GameScene: SKScene {
    
    
    let player = SKSpriteNode(imageNamed: "player-ufo.png")
    var touchingPlayer = false
    var gameTimer: Timer?

    override func didMove(to view: SKView) {
        // this method is called when your game scene is ready to run
        
        // set the background picture
        let background = SKSpriteNode(imageNamed: "space.jpg")
        background.zPosition = -1
        addChild(background)
        
        // add the space dust particles that go across the screen
        if let particles = SKEmitterNode(fileNamed: "SpaceDusk") {
            particles.advanceSimulationTime(10)
            particles.position.x = 512
            addChild(particles)
            
        }
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
        
        // set the player position on the screen
        player.position.x = -400
        player.zPosition = 1
        addChild(player)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // this method is called when the user touches the screen
        guard let touch = touches.first else{
            return }
        
        // find if the player touched the player icon
        let location = touch.location(in: self)
        let tappedNodes = nodes (at: location)
        
        if tappedNodes.contains(player) {
            touchingPlayer = true
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touchingPlayer else {
            return
        }
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)
        player.position = location

    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // this method is called when the user stops touching the screen
        touchingPlayer = false
    }
    
    override func update(_ currentTime: TimeInterval) {
        // this method is called before each frame is rendered
    }
    
    func createEnemy() {
        // this method creates the asteroid
        let sprite = SKSpriteNode (imageNamed: "asteroid")
        sprite.position = CGPoint(x: 1200, y: Int.random(in: -350...350))
        sprite.name = "enemy"
        sprite.zPosition = 1
        addChild(sprite)
        // add physics body
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
        sprite.physicsBody?.linearDamping = 0
        
    }
    
}

