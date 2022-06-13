//
//  Constants.swift
//  MacrosCalculator
//
//  Created by Stanislav on 01.05.2022.
//

import Foundation

enum Gender: String, CaseIterable, Identifiable {
    case male, female
    
    var id: String { self.rawValue }
}

enum LevelActivity: String, CaseIterable, Identifiable {
    case light = "Light: exercise 1-3 times per week",
         moderate = "Moderate: exercise 3-4 times per week",
         active  = "Active: exercise 4-5 times per week",
         veryActive = "Very Active: exercise 5-6 times per week",
         extraActive = "Extra Active: very intense exercise"
    
    var id: String { self.rawValue }
}

enum Goals: String, CaseIterable, Identifiable {
    case mildWeightLoss = "Mild weight loss of 0.25 kg per week",
         weightLoss = "Weight loss of 0.5 kg per week",
         extremeWeightLoss  = "Extreme weight loss of 1 kg per week",
         mildWeightGain = "Mild weight gain of 0.25 kg per week",
         weightGain = "Weight gain of 0.5 kg per week",
         extremeWeightGain = "Extreme weight gain of 1 kg per week"
    
    
    var id: String { self.rawValue }
}


