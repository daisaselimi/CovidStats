//
//  Enums.swift
//  CovidStats
//
//  Created by Isa  Selimi on 21.5.20.
//  Copyright © 2020 com.isaselimi. All rights reserved.
//

import Foundation

enum CDOperationType {
    case save
    case read
    case delete
}

enum CoreDataEntity: String {
    case totalData = "TotalDataCD"
    case countryData = "CountryDataCD"
}
