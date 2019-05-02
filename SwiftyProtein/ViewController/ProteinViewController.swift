//
//  ProteinViewController.swift
//  SwiftyProtein
//
//  Created by Shinya Yamada on 3/29/19.
//  Copyright © 2019 Shinya Yamada. All rights reserved.
//

import UIKit
import SceneKit

class ProteinViewController: UIViewController {

	@IBOutlet weak var ligandsView: SCNView!
	
	var ligandsName: String?
	var atoms: [Atom] = []

    /*
    ** When view loads from memory, register share action on right bar button and start protein info request
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareAction))
		initInfo()
    }

    /*
    ** Request protein information with callback
    ** callback adds inits Atom objects, appends each to controller member array, registers
    ** Atoms connections to Atom member array. Draws Atoms by calling drawLigand
    */
    
	func initInfo() {
        let scene = SCNScene()
		guard let name = ligandsName else { return }
		getModelInfo(of: name) { [weak self] content in
			guard let `self` = self else { return }
			let lines = content.split(separator: "\n")
			var i = 0;
			self.atoms = []
			lines.forEach({ element in
				let infos = element.split(separator: " ")
				//print(infos)
				if (infos[0] == "ATOM") {
					let atom: Atom = Atom(id: Int(infos[1]) ?? 0,
										  type: CPK(rawValue: String(infos[11])) ?? .none,
										  x: Float(infos[6]) ?? 0,
										  y: Float(infos[7]) ?? 0,
										  z: Float(infos[8]) ?? 0)
					self.atoms.append(atom)
				} else if (infos[0] == "CONECT") {
                    print(infos)
					if (self.atoms.count <= i || infos.count < 2) {
						i += 1
						return
					}
					self.atoms[i].connections = infos[2...].map {Int($0) ?? 0}
					i += 1
				}
			})
			//self.atoms.forEach { print($0) }
			self.drawLigand(atoms: self.atoms)
            print(self.atoms[0].node!.position, self.atoms[1].node!.position)
            let bondNode = self.bond(startPoint: self.atoms[0].node!.position, endPoint: self.atoms[1].node!.position, color: UIColor.black)
            //let bondNode = SCNNode(geometry: bond)
            bondNode.position = SCNVector3Make(15, 15, 10)
            scene.rootNode.addChildNode(bondNode)
		}
	}

    /*
    ** Request information regarding selected ligand from central database, passes response to
    ** callback for processing and drawing
    */
    
	func getModelInfo(of name: String, success: @escaping (String) -> Void) {
		guard let initial = name.first else { return }
		let url = URL(string: "http://ligand-expo.rcsb.org/reports/\(initial)/\(name)/\(name)_model.pdb")!
		let task = URLSession.shared.downloadTask(with: url) { localURL, urlResponse, error in
			DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if error != nil {
                    print(error!)
                    return
                } else {
                    print("url call successful")
                }
				guard let localURL = localURL else {
                    print("localURL guard failed")
                    return
                }
				guard let string = try? String(contentsOf: localURL) else {
                    print("string guard failed")
                    return
                }
                //print(localURL, string)
				success(string)
			}
		}
		task.resume()
		UIApplication.shared.isNetworkActivityIndicatorVisible = true
	}

    /*
    ** Iterates through Atoms array and draws individual atoms using Scenekit, by initializing
    ** SCNSPhere and SCNVector for SCCNode, and adding SCNNode to scene
    */
    
	func drawLigand(atoms: [Atom]) {
		let scene = SCNScene()

//        atoms.forEach { atom in
        for i in 0..<self.atoms.count {
			let ball = SCNSphere(radius: 0.2)
			ball.firstMaterial?.diffuse.contents = UIColor.atomColor(of: atoms[i].type)
			let ballNode = SCNNode(geometry: ball)
			ballNode.position = SCNVector3(x: atoms[i].x, y: atoms[i].y, z: atoms[i].z)
            self.atoms[i].node = ballNode
            if i == 0 || i == 1 { scene.rootNode.addChildNode(ballNode) }
		}
		ligandsView.scene = scene
		ligandsView.autoenablesDefaultLighting = true
		ligandsView.allowsCameraControl = true
	}

    /*
    ** Connection between Atoms is called a bond
    ** ref: https://stackoverflow.com/questions/35002232/draw-scenekit-object-between-two-points?rq=1
    */
    
	func bond(startPoint: SCNVector3, endPoint: SCNVector3, color : UIColor) -> SCNNode {
        /*
		let vertices: [SCNVector3] = [startPoint, endPoint]
		let data = NSData(bytes: vertices, length: MemoryLayout<SCNVector3>.size * vertices.count) as Data

		let vertexSource = SCNGeometrySource(data: data,
											 semantic: .vertex,
											 vectorCount: vertices.count,
											 usesFloatComponents: true,
											 componentsPerVector: 3,
											 bytesPerComponent: MemoryLayout<Float>.size,
											 dataOffset: 0,
											 dataStride: MemoryLayout<SCNVector3>.stride)


		let indices: [Int32] = [ 0, 1]

		let indexData = NSData(bytes: indices, length: MemoryLayout<Int32>.size * indices.count) as Data

		let element = SCNGeometryElement(data: indexData,
										 primitiveType: .line,
										 primitiveCount: indices.count/2,
										 bytesPerIndex: MemoryLayout<Int32>.size)

		let line = SCNGeometry(sources: [vertexSource], elements: [element])

		line.firstMaterial?.lightingModel = SCNMaterial.LightingModel.constant
		line.firstMaterial?.diffuse.contents = color
        */
        let indices: [Int32] = [0, 1]
        
        let source = SCNGeometrySource(vertices: [startPoint, endPoint])
        let element = SCNGeometryElement(indices: indices, primitiveType: .line)

		let lineNode = SCNNode(geometry: SCNGeometry(sources: [source], elements: [element]))
		return lineNode
	}

	@objc
	func shareAction(_ sender: UIBarButtonItem) {
		let items = ["This app is my favorite"]
		let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
		present(ac, animated: true)
	}
    
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        
        glLineWidth(10)
    }
}
