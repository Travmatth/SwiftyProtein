//
//  Bond.swift
//  SwiftyProtein
//
//  Created by Travis Matthews on 5/2/19.
//  Copyright © 2019 Shinya Yamada. All rights reserved.
//

import UIKit
import SceneKit

/*
 * Bonds model the connections between Atoms in a Ligand. Subclasses SCNNode
 * represents bond as an SCNGeometry element of type .line
 */

class BondViewController: SCNNode {
    init(start: AtomViewController, end: AtomViewController, width: GLfloat = 10) {
        super.init()
        let source = SCNGeometrySource(vertices: [start.position, end.position])
        let element = SCNGeometryElement(indices: [0, 1] as [Int32], primitiveType: .line)
        let line = SCNGeometry(sources: [source], elements: [element])
        line.firstMaterial?.diffuse.contents = UIColor.black
        glLineWidth(width)
        self.geometry = line
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
}
