//
//  LoginViewController.swift
//  SwiftyProtein
//
//  Created by Shinya Yamada on 3/29/19.
//  Copyright © 2019 Shinya Yamada. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {

	@IBOutlet weak var loginBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
		initUI()
    }

	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}

	func initUI() {
		let context = LAContext()
		if !context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
			loginBtn.isHidden = true
		}
	}

	@IBAction func authWithTouchID(_ sender: UIButton) {
		authenticateUser()
	}

	func toProteinList() {
		let st = UIStoryboard(name: "ProteinList", bundle: nil)
		guard let vc = st.instantiateViewController(withIdentifier: "ProteinList") as? ProteinListViewController else { return }
		self.present(vc, animated: true, completion: nil)
	}
    
	func authenticateUser() {
		let context = LAContext()
		let reason = "Identify yourself!"
		context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
			[unowned self] success, authenticationError in

			DispatchQueue.main.async {
				if success {
					let generator = UIImpactFeedbackGenerator(style: .medium)
					generator.impactOccurred()
					self.toProteinList()
				}
				let ac = UIAlertController(title: "Authentication failed", message: "Sorry!", preferredStyle: .alert)
				ac.addAction(UIAlertAction(title: "OK", style: .default))
				self.present(ac, animated: true)
			}
		}
	}
}
