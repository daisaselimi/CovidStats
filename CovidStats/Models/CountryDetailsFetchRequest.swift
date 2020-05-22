//
//  CovidFetchRequest.swift
//  CovidStats
//
//  Created by Isa  Selimi on 17.5.20.
//  Copyright © 2020 com.isaselimi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CountryDetailsFetchRequest: ObservableObject{
    
    //inst key: d172e810e7msh47584ae043c146dp12d8eejsnb0b3c42c4a59
    //my key: 3aa8f9c653msh84b2de04ac91ceap1b6b1bjsne9df2764bcc3
    
    
    @Published var detailsData: CountryDetails!
    @Published var isResultEmpty: Bool?
    
    let headers: HTTPHeaders = [
        "x-rapidapi-host": "covid-193.p.rapidapi.com",
        "x-rapidapi-key": "3aa8f9c653msh84b2de04ac91ceap1b6b1bjsne9df2764bcc3"
    ]
    
    init() {
        detailsData = CountryDetails(country: "", confirmed: 0, active: 0, newCases: 0, critical: 0, newDeaths: 0, totalDeaths: 0, totalTests: 0, recovered: 0)
    }
    
    func getDetailsData(country: String) {
        
        AF.request("https://covid-193.p.rapidapi.com/statistics?country=\(country)", headers: headers).responseJSON { (response) in
            
            let result = response.data
            
            if result != nil {
                let json = JSON(result!)
                if json["response"].isEmpty {
                    self.isResultEmpty = true
                    return
                }
                
                let response = json["response"][0]
                print(response["tests"]["total"])
                let country = response["country"].stringValue
                let active = response["cases"]["active"].intValue
                let critical = response["cases"]["critical"].intValue
                let newCases = response["cases"]["new"].intValue
                let confirmed = response["cases"]["total"].intValue
                let recovered = response["cases"]["recovered"].intValue
                let newDeaths = response["deaths"]["new"].intValue
                let totalDeaths = response["deaths"]["total"].intValue
                let totalTests = response["tests"]["total"].intValue
                self.detailsData = CountryDetails(country: country, confirmed: confirmed, active: active, newCases: newCases, critical: critical, newDeaths: newDeaths, totalDeaths: totalDeaths, totalTests: totalTests, recovered: recovered)
                self.isResultEmpty = false
                
            } else {
                self.isResultEmpty = true
            }
        }
    }
}
