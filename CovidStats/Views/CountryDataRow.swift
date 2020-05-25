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
            
            HStack(alignment: .center, spacing: 2) {

                Text(self.countryData.country)
                    .fontWeight(.medium)
                    .font(.subheadline)
                    .frame(width: (geometry.size.width)/4 - 2, alignment: .leading)
                
                Text(self.countryData.confirmed.formatNumber())
                    .fontWeight(.medium)
                    .font(.subheadline)
                    .frame(width: (geometry.size.width - 30)/4 - 2, height: 40, alignment: .leading)
                
                Text(self.countryData.deaths.formatNumber())
                    .fontWeight(.medium)
                    .font(.subheadline)
                    .frame(width: (geometry.size.width - 60)/4 - 2, height: 40, alignment: .leading)
                    .foregroundColor(.red)
                
                Text(self.countryData.recovered.formatNumber())
                    .fontWeight(.medium)
                    .font(.subheadline)
                    .frame(width:  (geometry.size.width - 30)/4 - 2, height: 40, alignment: .leading)
                    .foregroundColor(Color(.systemGreen))
            }.frame(width: geometry.size.width-30)
        }
    }
}

struct CountryDataRow_Previews: PreviewProvider {
    static var previews: some View {
        CountryDataRow(countryData: testCountryData)
    }
}
