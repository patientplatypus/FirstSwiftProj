//
//  Reducers.swift
//  FirstSwiftPrj
//
//  Created by Peter Weyand on 6/28/17.
//  Copyright © 2017 Peter Weyand. All rights reserved.
//

import Foundation
import ReSwift

func mainReducer(action: Action, state: AppState?) -> AppState {
    // if no state has been provided, create the default state
    var state = state ?? AppState()
    
    switch action {
    case let action as dataText1Action:
        state.dataText1 = action.payload
    case let action as LoginNameAction:
        state.LoginName = action.payload
    case let action as RealNameAction:
        state.RealName = action.payload
    case let action as AgeAction:
        state.Age = action.payload
    case let action as GenderAction:
        state.Gender = action.payload
    case let action as FavoriteColorAction:
        state.FavoriteColor = action.payload
    case let action as FavoriteFoodAction:
        state.FavoriteFood = action.payload
    case let action as profileIMGURLAction:
        state.profileIMGURL = action.payload
    case let action as profileIMGTITLEAction:
        state.profileIMGTITLE = action.payload
    default:
        break
    }
    
    return state
}
