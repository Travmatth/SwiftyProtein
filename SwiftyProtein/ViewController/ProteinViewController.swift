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

    override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareAction))
		initInfo()
    }

	func initInfo() {
		guard let name = ligandsName else { return }
		getModelInfo(of: name) { [weak self] content in
			guard let `self` = self else { return }
			let lines = content.split(separator: "\n")
			var i = 0;
			self.atoms = []
			lines.forEach({ element in
				let infos = element.split(separator: " ")
				print(infos)
				if (infos[0] == "ATOM") {
					let atom: Atom = Atom(id: Int(infos[1]) ?? 0,
										  type: CPK(rawValue: String(infos[11])) ?? .none,
										  x: Float(infos[6]) ?? 0,
										  y: Float(infos[7]) ?? 0,
										  z: Float(infos[8]) ?? 0)
					self.atoms.append(atom)
				} else if (infos[0] == "CONECT") {
					if (self.atoms.count <= i || infos.count < 2) {
						i += 1
						return
					}
					self.atoms[i].connections = infos[2...].map {Int($0) ?? 0}
					i += 1
				}
			})
			self.atoms.forEach { print($0) }
			self.drawLigand(atoms: self.atoms)
		}
	}

	func getModelInfo(of name: String, success: @escaping (String) -> Void) {
		guard let initial = name.first else { return }
		let url = URL(string: "http://ligand-expo.rcsb.org/reports/\(initial)/\(name)/\(name)_model.pdb")!
		let task = URLSession.shared.downloadTask(with: url) { localURL, urlResponse, error in
			DispatchQueue.main.async {
				guard let localURL = localURL else { return }
				guard let string = try? String(contentsOf: localURL) else { return }
				UIApplication.shared.isNetworkActivityIndicatorVisible = false
				success(string)
			}
		}
		task.resume()
		UIApplication.shared.isNetworkActivityIndicatorVisible = true
	}

	func drawLigand(atoms: [Atom]) {
		let scene = SCNScene()

		atoms.forEach { atom in
			let ball = SCNSphere(radius: 0.2)
			ball.firstMaterial?.diffuse.contents = UIColor.atomColor(of: atom.type)
			let ballNode = SCNNode(geometry: ball)
			ballNode.position = SCNVector3(x: atom.x, y: atom.y, z: atom.z)
			scene.rootNode.addChildNode(ballNode)
		}
		ligandsView.scene = scene
		ligandsView.autoenablesDefaultLighting = true
		ligandsView.allowsCameraControl = true
	}

	func line(startPoint: SCNVector3, endPoint: SCNVector3, color : UIColor) -> SCNNode {
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

		let lineNode = SCNNode(geometry: line)
		return lineNode;
	}

	@objc
	func shareAction(_ sender: UIBarButtonItem) {
		let items = ["This app is my favorite"]
		let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
		present(ac, animated: true)
	}
}
