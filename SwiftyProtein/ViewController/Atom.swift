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

class Atom: SCNNode {
    init(info: [String], radius: CGFloat = 0.2) {
        super.init()
        let ball = SCNSphere(radius: radius)
        let type = CPK(rawValue: String(info[11])) ?? .none
        ball.firstMaterial?.diffuse.contents = UIColor.atomColor(of: type)
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
