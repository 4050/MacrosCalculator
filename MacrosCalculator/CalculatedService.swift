//
//  CalculatedService.swift
//  MacrosCalculator
//
//  Created by Stanislav on 30.04.2022.
//

import Foundation

struct CalculatedService {
    
    static var calculate = CalculatedService()
    
    func calcutateBMR(personalInfo: PersonalInfoModel) -> Double {
        var bmr: Double?
        let weight = personalInfo.weight! * 13.75
        let height = personalInfo.height! * 5.003
        let age = personalInfo.age! * 6.75
        switch personalInfo.gender {
        case .female:
            bmr = weight + height - age - 161
        case .male:
            bmr = weight + height - age + 5
        case .none:
            break
        }
        
        
        bmr = calcutateBMRWithLevelActivity(bmr: bmr, levelActivity: personalInfo.levelActivity ?? .light)
        bmr = selectGoal(bmr: bmr, selectedGoal: personalInfo.personalGoal ?? .extremeWeightLoss)
        
        return bmr ?? 0
    }
    
    func selectGoal(bmr: Double?, selectedGoal: Goals) -> Double {
        guard var bmrActivity = bmr else { return 0 }
        switch selectedGoal {
        case .extremeWeightLoss:
            bmrActivity -= calculatePercentage(value: bmrActivity, percentageVal: 20)
        case .mildWeightLoss:
            bmrActivity -= calculatePercentage(value: bmrActivity, percentageVal: 15)
        case .weightLoss:
            bmrActivity -= calculatePercentage(value: bmrActivity, percentageVal: 7)
        case .mildWeightGain:
            bmrActivity += calculatePercentage(value: bmrActivity, percentageVal: 7)
        case .weightGain:
            bmrActivity += calculatePercentage(value: bmrActivity, percentageVal: 15)
        case .extremeWeightGain:
            bmrActivity += calculatePercentage(value: bmrActivity, percentageVal: 20)
        }
        return bmrActivity
    }
    
    func calcutateBMRWithLevelActivity(bmr: Double?, levelActivity: LevelActivity) -> Double {
        guard var bmrActivity = bmr else { return 0 }
        switch levelActivity {
        case .light:
            bmrActivity *= 1.2
        case .moderate:
            bmrActivity *= 1.375
        case .active:
            bmrActivity *= 1.55
        case .veryActive:
            bmrActivity *= 1.725
        case .extraActive:
            bmrActivity *= 1.9
        }
        return bmrActivity
    }
    
   // Минимальная активность: A = 1,2.
   // Слабая активность: A = 1,375.
   // Средняя активность: A = 1,55.
   // Высокая активность: A = 1,725.
   // Экстра-активность: A = 1,9 (под эту категорию обычно подпадают люди, занимающиеся, например, тяжелой атлетикой, или другими силовыми //видами спорта с ежедневными тренировками, а также те, кто выполняет тяжелую физическую работу).
    
    func calculateProtein(calories: Double) -> Double {
        let protein = (calories * 250) / 4
        return protein
    }
    
    func calculateCarb(calories: Double) -> Double {
        let protein = (calories * 500) / 4
        return protein
    }
    
    func calculateFat(calories: Double) -> Double {
        let protein = (calories * 250) / 9
        return protein
    }
}

extension CalculatedService {
    public func calculatePercentage(value:Double,percentageVal:Double) -> Double {
        let val = value * percentageVal
        return val / 100.0
    }
}
