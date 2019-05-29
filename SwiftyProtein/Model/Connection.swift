//
//  Connection.swift
//  SwiftyProtein
//
//  Created by Travis Matthews on 5/3/19.
//  Copyright © 2019 Shinya Yamada. All rights reserved.
//

import Foundation

struct Coord {
    var x: Float
    var y: Float
    var z: Float

    init(x: Float, y: Float, z: Float) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    static func +(lhs: Coord, rhs: Coord) -> Coord {
        return Coord(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
    }
    
    static func /(lhs: Coord, rhs: Float) -> Coord {
        return (Coord(x: lhs.x / rhs, y: lhs.y / rhs, z: lhs.z / rhs))
    }
}

/*
 * Connections are used to identify the bonds between atoms, contain
 * the id's of the Atoms being mapped from/to. Conforming to the
 * Hashable/Equatable protocols allows structs to be used as Keys in
 * Dictionaries
 */

struct Connection: Hashable, Equatable {
    let from: Int
    let to: Int
    
    init(from: Int, to: Int) {
        self.from = from
        self.to = to
    }
    
    var hashValue: Int {
        return "\(from)\(to)".hashValue
    }
    
    static func ==(lhs: Connection, rhs: Connection) -> Bool {
        return lhs.from == rhs.from && lhs.to == rhs.to ? true : false
    }
}
