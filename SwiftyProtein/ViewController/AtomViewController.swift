//
//  Atom.swift
//  SwiftyProtein
//
//  Created by Travis Matthews on 5/3/19.
//  Copyright © 2019 Shinya Yamada. All rights reserved.
//

import UIKit
import SceneKit

/*
 * Atoms model the discrete Atoms in a Ligand
 * Subclasses SCNNode, represents atom as an SCNSphere
 */

class AtomViewController: SCNNode {
    var type: String!
    
    init(info: [String], radius: CGFloat = 0.2) {
        super.init()
        type = info[11]
        let ball = SCNSphere(radius: radius)
        let color = CPK(rawValue: String(type)) ?? .none
        ball.firstMaterial?.diffuse.contents = UIColor.atomColor(of: color)
        self.geometry = ball
        self.position = SCNVector3(
            x: Float(info[6]) ?? 0,
            y: Float(info[7]) ?? 0,
            z: Float(info[8]) ?? 0
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
}
