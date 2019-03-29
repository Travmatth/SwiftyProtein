//
//  ProteinListViewController.swift
//  SwiftyProtein
//
//  Created by Shinya Yamada on 3/29/19.
//  Copyright © 2019 Shinya Yamada. All rights reserved.
//

import UIKit

class ProteinListViewController: UIViewController {

	@IBOutlet weak var searchbar: UISearchBar!
	@IBOutlet weak var tableview: UITableView!

	var ligands: [String]?
	var ligs: [String]?

    override func viewDidLoad() {
        super.viewDidLoad()
		searchbar.delegate = self
		readText()
		initTableView()
    }

	func readText() {
		guard let file = Bundle.main.path(forResource: "ligands", ofType: "txt") else { return }
		do {
			let data = try String(contentsOfFile: file, encoding: .utf8)
			ligands = data.components(separatedBy: .newlines)
			ligs = ligands
		} catch {
			print(error)
		}
	}

	func initTableView() {
		tableview.delegate = self
		tableview.dataSource = self
	}

	override func viewWillLayoutSubviews() {
		self.navigationController?.isNavigationBarHidden = false
	}
}

extension ProteinListViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		ligs = searchText.isEmpty ? ligands : ligands?.filter{ $0.contains(searchText) }
		tableview.reloadData()
	}
}

extension ProteinListViewController: UITableViewDelegate {

}

extension ProteinListViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let ligands = ligs else { return 0 }
		return ligands.count
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
		guard let ligands = ligs else { return UITableViewCell() }
		cell.textLabel?.text = ligands[indexPath.row]
		return cell
	}
}
