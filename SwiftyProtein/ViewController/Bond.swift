//
//  Bond.swift
//  SwiftyProtein
//
//  Created by Travis Matthews on 5/2/19.
//  Copyright © 2019 Shinya Yamada. All rights reserved.
//

import UIKit
import SceneKit

class Bond: SCNNode {
    init(start: SCNNode, end: SCNNode, width: GLfloat = 10) {
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
