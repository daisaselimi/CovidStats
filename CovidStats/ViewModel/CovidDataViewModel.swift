//
//  CovidFetchRequest.swift
//  CovidStats
//
//  Created by Isa  Selimi on 17.5.20.
//  Copyright © 2020 com.isaselimi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData

class CovidDataViewModel: ObservableObject {
    
    @Published var allCountries: [CountryData] = []
    @Published var totalData: TotalsData = testTotalData
    
    //CoreData objects
    var totalDataCD: [TotalDataCD]!
    var allcountriesCD: [CountryDataCD]!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let headers: HTTPHeaders = [
        RapidApiContstants.host: RapidApiContstants.hostValue,
        RapidApiContstants.key: RapidApiContstants.keyValue
    ]
    
    init() {
        getCurrentTotal()
        getAllCountries()
    }
    
    func getCurrentTotal() {
        
        manipulateCoreData(objects: totalDataCD, operationType: .read, coreDataEntity: .totalData)
        var oldDate: Date!
        if UserDefaults.standard.object(forKey: lastFetchedFromWeb) != nil {
            oldDate = (UserDefaults.standard.object(forKey: lastFetchedFromWeb) as! Date)
        } else {
            oldDate = nil
        }
        if totalDataCD == nil || totalDataCD.isEmpty || minutesBetweenDates(oldDate == nil ? Date() : oldDate, Date()) > 15 {
            print("Fetched from api")
            if !totalDataCD.isEmpty {
                fetchTotalsFromCoreData()
            }
            fetchTotalFromWebAPI()
        } else {
            fetchTotalsFromCoreData()
        }
    }
    
    func fetchTotalsFromCoreData() {
        print("Fetched from CORE DATA!")
        var tempTotalData: [TotalsData] = []
        print(totalDataCD.count)
        totalDataCD.forEach { (td) in
            tempTotalData.append(TotalsData(confirmed: Int(td.confirmed), critical: Int(td.critical), deaths: Int(td.deaths), recovered: Int(td.recovered)))
        }
        self.totalData = tempTotalData.first!
    }
    
    func fetchTotalFromWebAPI() {
        AF.request("https://covid-19-data.p.rapidapi.com/totals?format=json", headers: headers).responseJSON { (response) in
            
            self.manipulateCoreData(objects: self.totalDataCD, operationType: .delete, coreDataEntity: .totalData)
            UserDefaults.standard.setValue(Date(), forKey: lastFetchedFromWeb)
            
            let result = response.data
            
            if result != nil {
                let json = JSON(result!)
                //print(json)
                let confirmed = json[0]["confirmed"].intValue
                let deaths = json[0]["deaths"].intValue
                let recovered = json[0]["recovered"].intValue
                let critical = json[0]["critical"].intValue
                self.totalData = TotalsData(confirmed: confirmed, critical: critical, deaths: deaths, recovered: recovered)
                let totalsDataCD = TotalDataCD(context: self.context)
                totalsDataCD.confirmed = Int64(confirmed)
                totalsDataCD.deaths = Int64(deaths)
                totalsDataCD.recovered = Int64(recovered)
                totalsDataCD.critical = Int64(critical)
                self.manipulateCoreData(objects: [totalsDataCD], operationType: .save, coreDataEntity: .totalData)
            } else {
                self.totalData = testTotalData
            }
        }
    }
    
    func getAllCountries() {
        
        manipulateCoreData(objects: allcountriesCD, operationType: .read, coreDataEntity: .countryData)
        
        var oldDate: Date!
        
        if UserDefaults.standard.object(forKey: lastFetchedFromWeb) != nil {
            oldDate = (UserDefaults.standard.object(forKey: lastFetchedFromWeb) as! Date)
        } else {
            oldDate = nil
        }
        
        if (allcountriesCD == nil || allcountriesCD.isEmpty) || minutesBetweenDates(oldDate == nil ? Date() : oldDate, Date()) > 15 {
            print("Fetched from api - ALL COUNTRIES")
            if !allcountriesCD.isEmpty {
                fetchAllCountriesFromCoreData()
            }
            fetchAllCountriesFromWebAPI()
        } else {
            
            fetchAllCountriesFromCoreData()
        }
    }
    
    func fetchAllCountriesFromCoreData() {
        print("Fetched from CORE DATA - ALL COUNTRIES")
        var tempAllCountriedData: [CountryData] = []
        allcountriesCD.forEach { (td) in
            tempAllCountriedData.append(CountryData(country: td.country!, confirmed: td.confirmed, critical: td.critical, deaths: td.deaths, recovered: td.recovered, longitute: td.longitude, latitude: td.latitude))
        }
        self.allCountries = tempAllCountriedData
    }
    
    func fetchAllCountriesFromWebAPI() {
        AF.request("https://covid-19-data.p.rapidapi.com/country/all?format=json", headers: headers).responseJSON { (response) in
            UserDefaults.standard.setValue(Date(), forKey: lastFetchedFromWeb)
            self.manipulateCoreData(objects: self.allcountriesCD, operationType: .delete, coreDataEntity: .countryData)
            let result = response.value
            var allCountries: [CountryData] = []
            if result != nil {
                
                let dataDictionary = result as! [Dictionary<String, AnyObject>]
                
                for countryData in dataDictionary {
                    
                    var country = countryData["country"] as? String ?? "Error"
                    if country.contains("Kosovo") {
                        country = "Kosovo"
                    }
                    let longitude = countryData["longitude"] as? Double ?? 0.0
                    let latitude = countryData["latitude"] as? Double ?? 0.0
                    
                    let confirmed = countryData["confirmed"] as? Int64 ?? 0
                    let deaths = countryData["deaths"] as? Int64 ?? 0
                    let recovered = countryData["recovered"] as? Int64 ?? 0
                    let critical = countryData["critical"] as? Int64 ?? 0
                    
                    let countryObject = CountryData(country: country, confirmed: confirmed, critical: critical, deaths: deaths, recovered: recovered, longitute: longitude, latitude: latitude)
                    allCountries.append(countryObject)
                    
                }
                
                self.allCountries = allCountries.sorted(by: { $0.confirmed > $1.confirmed })
                
                self.allCountries.forEach { (countryDetail) in
                    let countryDetailsCD = CountryDataCD(context: self.context)
                    countryDetailsCD.confirmed = countryDetail.confirmed
                    countryDetailsCD.country = countryDetail.country
                    countryDetailsCD.critical = countryDetail.critical
                    countryDetailsCD.deaths = countryDetail.deaths
                    countryDetailsCD.latitude = countryDetail.latitude
                    countryDetailsCD.longitude = countryDetail.longitute
                    countryDetailsCD.recovered = countryDetail.recovered
                    print("saved")
                    self.manipulateCoreData(objects: [countryDetailsCD], operationType: .save, coreDataEntity: .countryData)
                }
            }
        }
    }
    
    
    // MARK: CoreData functions
    func manipulateCoreData(objects: [NSManagedObject]?, operationType: CDOperationType, coreDataEntity: CoreDataEntity) {
        do {
            switch operationType {
            case .delete:
                let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: coreDataEntity.rawValue)
                let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                try context.execute(deleteRequest)
                try context.save()
            case .save:
                try context.save()
            case .read:
                if coreDataEntity == .totalData {
                    let request: NSFetchRequest = TotalDataCD.fetchRequest()
                    totalDataCD = try context.fetch(request)
                } else if coreDataEntity == .countryData {
                    let request: NSFetchRequest = CountryDataCD.fetchRequest()
                    allcountriesCD = try context.fetch(request)
                }
            }
        } catch {
            print("error manipulating context \(error)")
        }
    }
}
