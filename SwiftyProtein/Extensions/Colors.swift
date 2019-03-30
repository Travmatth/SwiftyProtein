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

	static var H: UIColor {
		return UIColor.white
	}

	static var C: UIColor {
		return UIColor.black
	}

	static var N: UIColor {
		return UIColor(red: 34, green: 50, blue: 255, alpha: 1)
	}

	static var O: UIColor {
		return UIColor(red: 255, green: 33, blue: 1, alpha: 1)
	}

	static var FnCI: UIColor {
		return UIColor(red: 34, green: 240, blue: 32, alpha: 1)
	}

	static var Br: UIColor {
		return UIColor(red: 153, green: 34, blue: 0, alpha: 1)
	}

	static var I: UIColor {
		return UIColor(red: 102, green: 0, blue: 187, alpha: 1)
	}

	static var He: UIColor {
		return UIColor(red: 5, green: 255, blue: 255, alpha: 1)
	}

	static var P: UIColor {
		return UIColor(red: 255, green: 153, blue: 0, alpha: 1)
	}

	static var S: UIColor {
		return UIColor(red: 255, green: 229, blue: 34, alpha: 1)
	}

	static var B: UIColor {
		return UIColor(red: 255, green: 170, blue: 119, alpha: 1)
	}

	static var Li: UIColor {
		return UIColor(red: 119, green: 2, blue: 255, alpha: 1)
	}

	static var Be: UIColor {
		return UIColor(red: 0, green: 119, blue: 1, alpha: 1)
	}

	static var Ti: UIColor {
		return UIColor(red: 153, green: 153, blue: 153, alpha: 1)
	}

	static var Fe: UIColor {
		return UIColor(red: 220, green: 119, blue: 2, alpha: 1)
	}

	static var Other: UIColor {
		return UIColor(red: 221, green: 119, blue: 255, alpha: 1)
	}
}
