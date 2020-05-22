//
//  CountryDataRow.swift
//  CovidStats
//
//  Created by Isa  Selimi on 17.5.20.
//  Copyright © 2020 com.isaselimi. All rights reserved.
//

import SwiftUI

struct CountryDataRow: View {
    
    var countryData: CountryData
    
    var body: some View {
        
        GeometryReader {
            geometry in
            
            HStack(spacing: 2) {
                
                Text(self.countryData.country)
                    .fontWeight(.bold)
                    .font(.subheadline)
                    .frame(width: geometry.size.width/4 + 18, alignment: .leading).padding(.leading, 15)
                
                Text(self.countryData.confirmed.formatNumber())
                    .fontWeight(.medium)
                    .font(.subheadline)
                    .frame(width:  geometry.size.width/4 - 2, height: 40, alignment: .leading)
                
                Text(self.countryData.deaths.formatNumber())
                    .fontWeight(.medium)
                    .font(.subheadline)
                    .frame(width:  geometry.size.width/4 - 18, height: 40, alignment: .leading)
                    .foregroundColor(.red)
                
                Text(self.countryData.recovered.formatNumber())
                    .fontWeight(.medium)
                    .font(.subheadline)
                    .frame(width:  geometry.size.width/4 - 2, height: 40, alignment: .leading)
                    .foregroundColor(Color(.systemGreen))
            }.frame(width: geometry.size.width)
        }
    }
}

struct CountryDataRow_Previews: PreviewProvider {
    static var previews: some View {
        CountryDataRow(countryData: testCountryData)
    }
}
