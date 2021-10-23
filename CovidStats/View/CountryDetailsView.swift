//
//  CountryDetailsView.swift
//  CovidStats
//
//  Created by Isa  Selimi on 18.5.20.
//  Copyright © 2020 com.isaselimi. All rights reserved.
//


import SwiftUI

struct CountryDetailsView: View {
    
    @ObservedObject var countryFetch = CountryDetailsVieWModel()
    @State var dataFetched = false
    var countryName: String!
    var countryData: CountryData!
    
    @ViewBuilder
    var body: some View {
        if countryFetch.isResultEmpty == nil {
            ActivityIndicator().frame(width: 50, height: 50).onAppear {
                self.countryFetch.getDetailsData(country: self.countryName.replacingOccurrences(of: " ", with: "-"))
            }  .navigationBarTitle(Text(self.countryName), displayMode: .inline)
            
        } else {
            ScrollView {
                VStack (spacing: 0){
                    if !countryFetch.isResultEmpty! {
                        Group {
                            CountryDetailsRowView(rowName: "Confirmed", numberOfCases: countryFetch.detailsData.confirmed.formatNumber())//.padding(.top, 40)
                            Divider()
                            CountryDetailsRowView(rowName: "Recovered", numberOfCases: countryFetch.detailsData.recovered.formatNumber(), color: Color(.systemGreen))
                            Divider()
                            CountryDetailsRowView(rowName: "Active cases", numberOfCases: countryFetch.detailsData.active.formatNumber(), color: Color(.systemOrange))
                            Divider()
                            CountryDetailsRowView(rowName: "New cases", numberOfCases: countryFetch.detailsData.newCases.formatNumber(), color: Color(.systemIndigo))
                            Spacer()
                        }
                        Group {
                            Divider()
                            CountryDetailsRowView(rowName: "Critical", numberOfCases: countryFetch.detailsData.critical.formatNumber(), color: Color(.systemPink))
                            Divider()
                            CountryDetailsRowView(rowName: "Total deaths", numberOfCases: countryFetch.detailsData.totalDeaths.formatNumber(), color: Color.red)
                            Divider()
                            CountryDetailsRowView(rowName: "New deaths", numberOfCases: countryFetch.detailsData.newDeaths.formatNumber(), color: Color(.systemPink))
                            Spacer().cornerRadius(20)
                            
                        }
                        Group {
                            Divider()
                            CountryDetailsRowView(rowName: "Fatality%", numberOfCases: String(format: "%.2f", countryFetch.detailsData.fatalityRate), color: Color(.red))
                            Divider()
                            CountryDetailsRowView(rowName: "Recovery%", numberOfCases: String(format: "%.2f", countryFetch.detailsData.recoveredRate), color: Color(.systemGreen))
                            Spacer()
                            CountryDetailsRowView(rowName: "Total tests", numberOfCases: countryFetch.detailsData.totalTests.formatNumber(), color: Color(.systemYellow))
                        }
                    } else {
                        Group {
                            CountryDetailsRowView(rowName: "Confirmed", numberOfCases: countryData.confirmed.formatNumber())//.padding(.top, 40)
                            Divider()
                            CountryDetailsRowView(rowName: "Recovered", numberOfCases: countryData.recovered.formatNumber(), color: Color(.systemGreen))
                            Divider()
                            CountryDetailsRowView(rowName: "Critical", numberOfCases: countryData.critical.formatNumber(), color: Color(.systemPink))
                            Divider()
                            CountryDetailsRowView(rowName: "Deaths", numberOfCases: countryData.deaths.formatNumber(), color: Color.red)
                            Divider()
                            CountryDetailsRowView(rowName: "Fatality%", numberOfCases: String(format: "%.2f", countryData.fatalityRate), color: Color(.red))
                        }
                        Group {
                            Divider()
                            CountryDetailsRowView(rowName: "Recovery%", numberOfCases: String(format: "%.2f", countryData.recoveredRate), color: Color(.systemGreen))
                        }
                    }
                }
                .cornerRadius(20).padding().padding(.top, 35)
            }
            .navigationBarTitle(Text(self.countryName), displayMode: .inline)
        }
    }
}



