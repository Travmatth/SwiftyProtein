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

    override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareAction))
		initInfo()
    }

	func initInfo() {
		guard let name = ligandsName else { return }
		getModelInfo(withName: name) { content in
			print(content)
		}
	}

	func getModelInfo(withName name: String, success: @escaping (String) -> Void) {
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

	override func viewDidAppear(_ animated: Bool) {
		let scene = SCNScene()

		let first = SCNSphere(radius: 1)
		let second = SCNSphere(radius: 0.3)
		let sphereNode = SCNNode(geometry: first)
		let secondSphereNode = SCNNode(geometry: second)
		secondSphereNode.position = SCNVector3(x: 3.0, y: 0.0, z: 0.0)
		scene.rootNode.addChildNode(sphereNode)
		scene.rootNode.addChildNode(secondSphereNode)
//		let ambientLightNode = SCNNode()
//		ambientLightNode.light = SCNLight()
//		ambientLightNode.light!.type = .ambient
//		ambientLightNode.light!.color = UIColor(white: 0.67, alpha: 1.0)
//		scene.rootNode.addChildNode(ambientLightNode)
		ligandsView.scene = scene
		ligandsView.autoenablesDefaultLighting = true
		ligandsView.allowsCameraControl = true
	}

	@objc
	func shareAction(_ sender: UIBarButtonItem) {
		let items = ["This app is my favorite"]
		let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
		present(ac, animated: true)
	}
}
