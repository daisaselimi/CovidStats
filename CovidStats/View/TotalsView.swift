//
//  TotalsView.swift
//  CovidStats
//
//  Created by Isa  Selimi on 17.5.20.
//  Copyright © 2020 com.isaselimi. All rights reserved.
//

import SwiftUI

struct TotalsView: View {
    
    var totalsData: TotalsData = testTotalData
    
    var body: some View {
        VStack {
            HStack {
                CardView(totalNumber: totalsData.confirmed.formatNumber(), title: "Confirmed")
                CardView(totalNumber: totalsData.recovered.formatNumber(), title: "Recovered", color: Color(.systemGreen))
                CardView(totalNumber: totalsData.critical.formatNumber(), title: "Critical", color: Color(.systemPink))
                CardView(totalNumber: totalsData.deaths.formatNumber(), title: "Deaths", color: .red)
            }
            HStack {
                CardView(totalNumber: String(format: "%.2f", totalsData.fatalityRate), title: "Death %", color: Color(.systemPink))
                
                CardView(totalNumber: String(format: "%.2f", totalsData.recoveredRate), title: "Recovery %", color: Color(.systemGreen))
            }
        }
        .frame(height: 170)
    }
}

struct TotalsView_Previews: PreviewProvider {
    static var previews: some View {
        TotalsView()
    }
}
