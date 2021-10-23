//
//  CountryDetailsRowView.swift
//  CovidStats
//
//  Created by Isa  Selimi on 18.5.20.
//  Copyright © 2020 com.isaselimi. All rights reserved.
//

import SwiftUI

struct CountryDetailsRowView: View {
    
    var rowName: String = ""
    var numberOfCases: String = ""
    var color: Color = .primary
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(rowName)
                    .font(.body)
                    .padding(15)
                Spacer()
                Text(numberOfCases)
                    .font(.subheadline)
                    .padding(15).foregroundColor(color)
                
            }.padding([.leading, .trailing]).background(Color(.systemGray6))
        }
    }
}

struct CountryDetailsRowView_Previews: PreviewProvider {
    static var previews: some View {
        CountryDetailsRowView()
    }
}
