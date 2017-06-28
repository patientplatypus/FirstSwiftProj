//
//  Actions.swift
//  FirstSwiftPrj
//
//  Created by Peter Weyand on 6/28/17.
//  Copyright © 2017 Peter Weyand. All rights reserved.
//

import Foundation
import ReSwift


struct dataText1Action: Action {
    let payload: String
}

struct LoginNameAction: Action {
    let payload: String
}

struct RealNameAction: Action {
    let payload: String
}

struct AgeAction: Action {
    let payload: Int
}

struct GenderAction: Action {
    let payload: String
}

struct FavoriteColorAction: Action {
    let payload: String
}

struct FavoriteFoodAction: Action {
    let payload: String
}

struct profileIMGURLAction: Action {
    let payload: String
}

struct profileIMGTITLEAction: Action {
    let payload: String
}
