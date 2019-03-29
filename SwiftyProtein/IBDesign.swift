//
//  IBDesign.swift
//  SwiftyProtein
//
//  Created by Shinya Yamada on 3/29/19.
//  Copyright © 2019 Shinya Yamada. All rights reserved.
//

import Foundation
import Foundation
import UIKit

// Original Interface Builder settings

@IBDesignable class CustomBtn: UIButton {
	@IBInspectable var cornerRadius: CGFloat = 0.0
	@IBInspectable var borderWidth: CGFloat = 0.0
	@IBInspectable var borderColor: UIColor = UIColor.clear


	override func draw(_ rect: CGRect) {
		self.layer.masksToBounds = true
		self.layer.cornerRadius = cornerRadius
		self.layer.borderColor = borderColor.cgColor
		self.layer.borderWidth = borderWidth

	}
}


@IBDesignable class CustomView: UIView{
	@IBInspectable var cornerRadius: CGFloat = 0.0
	@IBInspectable var background: UIColor = UIColor.clear

	override func draw(_ rect: CGRect) {
		self.layer.masksToBounds = true
		self.layer.cornerRadius = cornerRadius
		self.layer.backgroundColor = background.cgColor
	}

}

@IBDesignable class CustomImageView: UIImageView{
	@IBInspectable var cornerRadius: CGFloat = 0.0
	@IBInspectable var borderWidth: CGFloat = 0.0
	@IBInspectable var borderColor: UIColor = UIColor.clear

	override func draw(_ rect: CGRect) {
		self.layer.masksToBounds = true
		self.layer.cornerRadius = cornerRadius
		self.layer.borderWidth = borderWidth
		self.layer.borderColor = borderColor.cgColor
	}
}
