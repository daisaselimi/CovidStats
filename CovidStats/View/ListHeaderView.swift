//
//  ListHeaderView.swift
//  CovidStats
//
//  Created by Isa  Selimi on 17.5.20.
//  Copyright © 2020 com.isaselimi. All rights reserved.
//

import SwiftUI

struct ListHeaderView: View {
    
    init() {
        UITableView.appearance().separatorInset = .zero
        UITableView.appearance().layoutMargins = .zero
    }
    
    var body: some View {
        GeometryReader {
            geometry in
            HStack(alignment: .center, spacing: 2){
                Text("Country")
                    .fontWeight(.bold)
                    .font(.system(size: 14))
                    .frame(width: abs((geometry.size.width)/4 - 2), alignment: .leading)
                
                Text("Confirmed")
                    .fontWeight(.bold)
                    .font(.system(size: 14))
                    .frame(width: abs((geometry.size.width - 30)/4 - 2), height: 40, alignment: .leading)
                
                Text("Deaths")
                    .fontWeight(.bold)
                    .font(.system(size: 14))
                    .frame(width: abs((geometry.size.width - 60)/4 -  2), height: 40, alignment: .leading)
                
                Text("Recovered")
                    .fontWeight(.bold)
                    .font(.system(size: 14))
                    .frame(width: abs((geometry.size.width - 30)/4 - 2), height: 40, alignment: .leading)
            }
            .frame(width: geometry.size.width, height: 40)
            .background(Color(.systemGray6))
        }
    }
}

struct ListHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ListHeaderView()
    }
}
