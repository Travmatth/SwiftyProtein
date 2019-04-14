//
//  Atom.swift
//  SwiftyProtein
//
//  Created by Shinya Yamada on 3/30/19.
//  Copyright © 2019 Shinya Yamada. All rights reserved.
//

import Foundation
import UIKit

enum CPK: String {
	case H
	case C
	case N
	case O
	case F
	case Cl
	case Br
	case I

	// same group
	case He
	case Ne
	case Ar
	case Xe
	case Kr

	case P
	case S
	case B

	// same group
	case Li
	case Na
	case K
	case Rb
	case Cs
	case Fr

	// same group
	case Be
	case Mg
	case Ca
	case Sr
	case Ba
	case Ra

	case Ti
	case Fe
	case other
	case none
}

struct Atom {
	var id: Int
	var type: CPK
	var x: Float
	var y: Float
	var z: Float
	var connections: [Int]

	init() {
		id = 0
		type = .none
		x = 0
		y = 0
		z = 0
		connections = []
	}
	init (id: Int, type: CPK, x: Float, y: Float, z: Float, connections: [Int] = []) {
		self.id = id;
		self.type = type;
		self.x = x;
		self.y = y;
		self.z = z;
		self.connections = connections;
	}
}
