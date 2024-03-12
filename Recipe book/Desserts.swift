//
//  DessertView.swift
//  Recipe book
//
//  Created by Yee chuen Teoh on 3/11/24.
//

import Foundation

struct Meal: Codable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
}

struct MealsResponse: Codable {
    let meals: [Meal]
}
