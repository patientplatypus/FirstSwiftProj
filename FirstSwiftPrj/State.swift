//
//  State.swift
//  FirstSwiftPrj
//
//  Created by Peter Weyand on 6/28/17.
//  Copyright © 2017 Peter Weyand. All rights reserved.
//

import Foundation
import ReSwift



struct AppState: StateType {
    var dataText1: String = ""
    var LoginName: String = ""
    var RealName: String = ""
    var Age: Int = 0
    var Gender: String = ""
    var FavoriteColor: String = ""
    var FavoriteFood: String = ""
    var profileIMGURL: String = ""
    var profileIMGTITLE: String = ""
}
