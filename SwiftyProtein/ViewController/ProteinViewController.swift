//
//  ProteinViewController.swift
//  SwiftyProtein
//
//  Created by Shinya Yamada on 3/29/19.
//  Copyright © 2019 Shinya Yamada. All rights reserved.
//

import UIKit
import SceneKit

/*
 * Display selected Ligand with CPK Coloring using Scenekit
 * Note: ATOM/CONECT contains information directly captured by the structure determination methods.
 * As such, most entries do not fully capture the shape and may not contain every atom/bond
 * https://pdb101.rcsb.org/learn/guide-to-understanding-pdb-data/missing-coordinates-and-biological-assemblies
 */
class ProteinViewController: UIViewController {

	@IBOutlet weak var ligandsView: SCNView!
	
    /*
     * Name of ligand selected by user for viewing in ProteinListViewController
     */
    
	var ligandsName: String?
    
    /*
     * Dictionary mapping atom id -> Atom SCNNode
     * Represents all given Atoms in given ligand
     */
    
    var atoms: Dictionary<Int, Atom> = [:]

    /*
     * Dictionary mapping Connection(to, from) struct -> Bond SCNNode
     * Represents all valid Bonds between indidividual Atoms in given ligand
     */
    
    var bonds: Dictionary<Connection, Bond> = [:]
    
    /*
     * When view loads from memory, register share action on right bar button
     * and start protein info request
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(shareAction)
        )
		initInfo()
    }

    /*
     * Initiate protein info http request with callback
     * Callback iterates through lines of response, adds Atom entries to atoms dictionary
     * with id as key. Iterates through connection entries and, if Bond valid and not already present,
     * adds Bond to bonds dictionary, where key is Connection struct with id's of Atom connecting to
     * and from. Iterates through atom and bond dictionaries to add each object to the scene then sets
     * appropriate ligandsView options, registers scene to ligandsView.
     */
    
	func initInfo() {
        let scene = SCNScene()
		guard let name = ligandsName else { return }
		getModelInfo(of: name) { [weak self] content in
			guard let `self` = self else { return }
			let lines = content.split(separator: "\n")
			lines.forEach({ element in
                let info = element.components(separatedBy: " ").filter { $0 != "" }
                if (info[0] == "ATOM") {
                    self.atoms[Int(info[1]) ?? 0] = Atom(info: info)
                } else if (info[0] == "CONECT") {
                    guard let start = Int(info[1]), self.atoms[start] != nil else { return }
                    info[2...]
                        .map { Int($0) ?? 0 }
                        .filter { $0 != 0 && self.atoms[$0] != nil }
                        .filter { self.bonds[Connection(from: $0, to: start)] == nil }
                        .forEach { end -> Void in
                            let bond = Bond(start: self.atoms[start]!, end: self.atoms[end]!)
                            self.bonds[Connection(from: start, to: end)] = bond
                        }
                }
			})
            for (_, atom) in self.atoms { scene.rootNode.addChildNode(atom) }
            for (_, bond) in self.bonds { scene.rootNode.addChildNode(bond) }
            self.ligandsView.scene = scene
            self.ligandsView.autoenablesDefaultLighting = true
            self.ligandsView.allowsCameraControl = true
        }
	}

    /*
     * Request information regarding selected ligand from central database
     * pass response to callback (inside initinfo) for processing and drawing
     */
    
	func getModelInfo(of name: String, success: @escaping (String) -> Void) {
        guard let initial = name.first else { return }
		let url = URL(string: "http://ligand-expo.rcsb.org/reports/\(initial)/\(name)/\(name)_model.pdb")!
		let task = URLSession.shared.downloadTask(with: url) { localURL, urlResponse, err in
			DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if err != nil { print(err!) }
                else if localURL == nil { return }
                else {
                    do { success(try String(contentsOf: localURL!)) }
                    catch { print("ProteinViewController: \(error)") }
                }
			}
		}
		task.resume()
		UIApplication.shared.isNetworkActivityIndicatorVisible = true
	}

    /*
     * Share selected ligand
     */
    
	@objc
	func shareAction(_ sender: UIBarButtonItem) {
		let items = ["This app is my favorite"]
		let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
		present(ac, animated: true)
	}
}
