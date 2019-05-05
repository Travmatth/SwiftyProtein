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
    @IBOutlet weak var defaultLoginBtn: CustomBtn!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var error: NSError? = nil
        if LAContext().canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            defaultLoginBtn.isHidden = true
            loginBtn.isHidden = false
            
        } else {
            loginBtn.isHidden = true
            defaultLoginBtn.isHidden = false
        }
        if error != nil { print(error!) }
    }

	override func viewDidLayoutSubviews() {
		self.navigationController?.isNavigationBarHidden = true;
	}

	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}

	@IBAction func authWithTouchID(_ sender: UIButton) {
        let context = LAContext()
        let reason = "Identify yourself!"
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
            [unowned self] success, authenticationError in
            
            DispatchQueue.main.async {
                if !success {
                    let ac = UIAlertController(title: "Authentication failed", message: "Sorry!", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(ac, animated: true)
                    return
                }
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.impactOccurred()
                self.login(nil)
            }
        }
	}

	@IBAction func login(_ sender: UIButton?) {
        let st = UIStoryboard(name: "ProteinList", bundle: nil)
        guard let vc = st.instantiateViewController(withIdentifier: "ProteinList") as? ProteinListViewController else { return }
        vc.title = "Proteins"
        self.navigationController?.pushViewController(vc, animated: true)
	}
}
