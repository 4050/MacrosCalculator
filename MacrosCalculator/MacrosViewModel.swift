//
//  MacrosViewModel.swift
//  MacrosCalculator
//
//  Created by Stanislav on 16.04.2022.
//

import Foundation

class MacrosViewModel: ObservableObject {
    
    @Published var calories: Double?
    @Published var protein: Double?
    @Published var carbs: Double?
    @Published var fat: Double?
    
    private var personalInfoViewModel = PersonalInfoModel()
    private var macrosModel = MacrosModel()
    
    var personalInfo = PersonalInfoModel()
    
    
    func getMacros(personalInfo: PersonalInfoModel) {
        let macros = macrosModel.calculatedMacros(personalInfo: personalInfo)
        calories = macros.calories
        protein = macros.protein! / 1000
        carbs = macros.carbs! / 1000
        fat = macros.fat! / 1000
    }
}
