//
//  CPK.swift
//  SwiftyProtein
//
//  Created by Travis Matthews on 5/3/19.
//  Copyright © 2019 Shinya Yamada. All rights reserved.
//

import Foundation

/*
 * In chemistry, the CPK coloring is a popular color convention for distinguishing
 * atoms of different chemical elements in molecular models.
 * https://en.wikipedia.org/wiki/CPK_coloring
 */

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
