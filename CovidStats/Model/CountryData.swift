//
//  CountryData.swift
//  CovidStats
//
//  Created by Isa  Selimi on 23.10.21.
//  Copyright © 2021 com.isaselimi. All rights reserved.
//

import Foundation

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
