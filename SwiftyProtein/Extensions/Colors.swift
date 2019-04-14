//
//  Colors.swift
//  SwiftyProtein
//
//  Created by Shinya Yamada on 3/30/19.
//  Copyright © 2019 Shinya Yamada. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
	public convenience init?(hex: String) {
		let r, g, b, a: CGFloat

		if hex.hasPrefix("#") {
			let start = hex.index(hex.startIndex, offsetBy: 1)
			let hexColor = String(hex[start...])

			if hexColor.count == 8 {
				let scanner = Scanner(string: hexColor)
				var hexNumber: UInt64 = 0

				if scanner.scanHexInt64(&hexNumber) {
					r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
					g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
					b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
					a = CGFloat(hexNumber & 0x000000ff) / 255

					self.init(red: r, green: g, blue: b, alpha: a)
					return
				}
			}
		}
		return nil
	}

	static func atomColor(of type: CPK) -> UIColor {
		switch (type) {
		case .H:
			return UIColor.H
		case .C:
			return UIColor.C
		case .N:
			return UIColor.N
		case .O:
			return UIColor.O
		case .F, .Cl:
			return UIColor.F
		case .Br:
			return UIColor.Br
		case .I:
			return UIColor.I
		case .He, .Ne, .Ar, .Xe, .Kr, .P, .S, .B:
			return UIColor.He
		case .Li, .Na, .K, .Rb, .Cs, .Fr:
			return UIColor.Li
		case .Be, .Mg, .Ca, .Sr, .Ba, .Ra:
			return UIColor.Be
		case .Ti:
			return UIColor.Ti
		case .Fe:
			return UIColor.Fe
		case .other:
			return UIColor.Other
		case .none:
			return UIColor.white
		}
	}

	static var H: UIColor {
		return UIColor.white
	}

	static var C: UIColor {
		return UIColor.gray
	}

	static var N: UIColor {
		return UIColor(red: 34/255, green: 50/255, blue: 255/255, alpha: 1)
	}

	static var O: UIColor {
		return UIColor(red: 255/255, green: 33/255, blue: 1/255, alpha: 1)
	}

	static var F: UIColor {
		return UIColor(red: 34/255, green: 240/255, blue: 32/255, alpha: 1)
	}

	static var Br: UIColor {
		return UIColor(red: 153/255, green: 34/255, blue: 0/255, alpha: 1)
	}

	static var I: UIColor {
		return UIColor(red: 102/255, green: 0/255, blue: 187/255, alpha: 1)
	}

	static var He: UIColor {
		return UIColor(red: 5/255, green: 255/255, blue: 255/255, alpha: 1)
	}

	static var P: UIColor {
		return UIColor(red: 255/255, green: 153/255, blue: 0/255, alpha: 1)
	}

	static var S: UIColor {
		return UIColor(red: 255/255, green: 229/255, blue: 34/255, alpha: 1)
	}

	static var B: UIColor {
		return UIColor(red: 255/255, green: 170/255, blue: 119/255, alpha: 1)
	}

	static var Li: UIColor {
		return UIColor(red: 119/255, green: 2/255, blue: 255/255, alpha: 1)
	}

	static var Be: UIColor {
		return UIColor(red: 0/255, green: 119/255, blue: 1/255, alpha: 1)
	}

	static var Ti: UIColor {
		return UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
	}

	static var Fe: UIColor {
		return UIColor(red: 220/255, green: 119/255, blue: 2/255, alpha: 1)
	}

	static var Other: UIColor {
		return UIColor(red: 221/255, green: 119/255, blue: 255/255, alpha: 1)
	}
}
