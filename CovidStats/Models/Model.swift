//
//  Model.swift
//  CovidStats
//
//  Created by Isa  Selimi on 17.5.20.
//  Copyright © 2020 com.isaselimi. All rights reserved.
//

import Foundation

struct TotalData {
    
    let confirmed: Int
    let critical: Int
    let deaths: Int
    let recovered: Int
    
    var fatalityRate: Double {
        if deaths == 0 && confirmed == 0 {
            return 0
        }
        return (100.00 * Double(deaths)) / Double(confirmed)
    }
    
    var recoveredRate: Double {
        if recovered == 0 && confirmed == 0 {
            return 0
        }
        return (100.00 * Double(recovered)) / Double(confirmed)
    }
}

struct CountryData {
    
    let country: String
    let confirmed: Int64
    let critical: Int64
    let deaths: Int64
    let recovered: Int64
    let longitute: Double
    let latitude: Double
    
    var fatalityRate: Double {
        if deaths == 0 && confirmed == 0 {
            return 0
        }
        return (100.00 * Double(deaths)) / Double(confirmed)
    }
    
    var recoveredRate: Double {
        if recovered == 0 && confirmed == 0 {
            return 0
        }
        return (100.00 * Double(recovered)) / Double(confirmed)
    }
}

struct CountryDetails {
    
    let country: String
    let confirmed: Int
    let active: Int
    let newCases:Int
    let critical: Int
    let newDeaths: Int
    let totalDeaths: Int
    let totalTests: Int
    let recovered: Int
    
    var fatalityRate: Double {
        if totalDeaths == 0 && confirmed == 0 {
            return 0
        }
        return (100.00 * Double(totalDeaths)) / Double(confirmed)
    }
    
    var recoveredRate: Double {
        if recovered == 0 && confirmed == 0 {
            return 0
        }
        return (100.00 * Double(recovered)) / Double(confirmed)
    }
}

let testTotalData = TotalData(confirmed: 0, critical: 0, deaths: 0, recovered: 0)
let testCountryData = CountryData(country: "Test", confirmed: 0, critical: 0, deaths: 0, recovered: 0, longitute: 0.0, latitude: 0.0)
