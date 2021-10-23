//
//  TotalsData.swift
//  CovidStats
//
//  Created by Isa  Selimi on 23.10.21.
//  Copyright © 2021 com.isaselimi. All rights reserved.
//

import Foundation

struct TotalsData {
    
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
