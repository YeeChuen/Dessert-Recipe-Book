//
//  DessertDetail.swift
//  Recipe book
//
//  Created by Yee chuen Teoh on 3/11/24.
//

import Foundation

struct MealDetail: Codable {
    let idMeal: String
    let strMeal: String
    let strDrinkAlternate: String?
    let strCategory: String
    let strArea: String
    let strInstructions: String
    let strMealThumb: String
    let strTags: String?
    let strYoutube: String?
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?
    let strSource: String?
    let strImageSource: String?
    let strCreativeCommonsConfirmed: String?
    let dateModified: String?
    
    var ingredients: String {
        var result = ""
        let mirror = Mirror(reflecting: self)
        for case let (label?, value) in mirror.children {
            if label.hasPrefix("strIngredient"), let ingredient = value as? String {
                let measureLabel = label.replacingOccurrences(of: "strIngredient", with: "strMeasure")
                if let measureValue = mirror.children.first(where: { $0.label == measureLabel })?.value as? String {
                                if !ingredient.isEmpty && !measureValue.isEmpty {
                                    result += "\(ingredient) - \(measureValue)\n"
                                } else if !ingredient.isEmpty {
                                    result += "\(ingredient)\n"
                                }
                            }
            }
        }
        return result
    }
    
    var instructions: String{
        var result = ""
        // let stringWithoutNewlines = stringWithNewlines.replacingOccurrences(of: "\n", with: "")
        let mirror = Mirror(reflecting: self)
        for case let (label?, value) in mirror.children {
            if label.hasPrefix("strInstructions"), let steps = value as? String{
                let newSteps = steps.replacingOccurrences(of: "\r\n\r\n", with: "\r\n")
                result = newSteps.replacingOccurrences(of: "\r\n", with: "\r\n\r\n")
            }
        }
        return result
    }
}

struct MealDetailResponse: Codable {
    let meals: [MealDetail]
}
