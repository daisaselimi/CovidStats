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
            
            HStack(spacing: 2){
                
                Text("Country")
                    .fontWeight(.bold)
                    .font(.subheadline)
                    .frame(width: geometry.size.width/4 + 18, alignment: .leading).padding(.leading, 15)
                
                Text("Confirmed")
                    .fontWeight(.bold)
                    .font(.subheadline)
                    .frame(width:  geometry.size.width/4 - 2, height: 40, alignment: .leading)
                
                Text("Deaths")
                    .fontWeight(.bold)
                    .font(.subheadline)
                    .frame(width:  geometry.size.width/4 -  18, height: 40, alignment: .leading)
                
                Text("Recovered")
                    .fontWeight(.bold)
                    .font(.subheadline)
                    .frame(width:  geometry.size.width/4 - 2, height: 40, alignment: .leading)
            }
            .background(Color(.systemGray6)).frame(width: geometry.size.width, height: 40)
        }
        
    }
}

struct ListHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ListHeaderView()
    }
}
