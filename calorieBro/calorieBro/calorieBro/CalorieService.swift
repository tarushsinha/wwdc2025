//
//  CalorieService.swift
//  calorieBro
//
//  Created by Tarush Sinha on 6/10/25.
//

import Foundation

enum Gender: String {
    case male = "Male"
    case female = "Female"
    case other = "Other"
}

enum ActivityLevel {
    case sedentary, light, moderate, active, veryActive

    var multiplier: Double {
        switch self {
        case .sedentary: return 1.2
        case .light: return 1.375
        case .moderate: return 1.55
        case .active: return 1.725
        case .veryActive: return 1.9
        }
    }
}

struct CalorieService {
    
    static func convertToKg(pounds: Double) -> Double {
        return pounds * 0.453592
    }
    
    static func convertToCm(inches: Double) -> Double {
        return inches * 2.54
    }
    
    static func calculateBMR(age: Int, height: Double, weight: Double, gender: Gender) -> Double {
        let heightCm = convertToCm(inches: height)
        let weightKg = convertToKg(pounds: weight)
        
        switch gender {
        case .male:
            return 10*weightKg + 6.25*heightCm - 5*Double(age) + 5
        case .female:
            return 10*weightKg + 6.25*heightCm - 5*Double(age) - 161
        case .other:
            return 0
        }
    }
    
    static func adjustForActivity(bmr: Double, activityLevel: ActivityLevel) -> Double {
        return bmr * activityLevel.multiplier
    }
}
