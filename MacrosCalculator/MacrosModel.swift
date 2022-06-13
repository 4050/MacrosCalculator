//
//  MacrosModel.swift
//  MacrosCalculator
//
//  Created by Stanislav on 16.04.2022.
//

import Foundation

struct MacrosModel {
    var calories: Double?
    var protein: Double?
    var carbs: Double?
    var fat: Double?
    
    init() {}
    init(calories: Double?, protein: Double?, carbs: Double?, fat: Double?) {
        self.calories = calories
        self.protein = protein
        self.carbs = carbs
        self.fat = fat
    }
    
    func calculatedMacros(personalInfo: PersonalInfoModel) -> MacrosModel {

        let calories = CalculatedService.calculate.calcutateBMR(personalInfo: personalInfo)
        let protein = CalculatedService.calculate.calculateProtein(calories: calories)
        let carbs = CalculatedService.calculate.calculateCarb(calories: calories)
        let fat = CalculatedService.calculate.calculateFat(calories: calories)
        
        return MacrosModel(calories: calories, protein: protein, carbs: carbs, fat: fat)
    }
    
}
