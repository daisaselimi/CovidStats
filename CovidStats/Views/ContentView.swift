//
//  ContentView.swift
//  CovidStats
//
//  Created by Isa  Selimi on 16.5.20.
//  Copyright © 2020 com.isaselimi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    //@ObservedObject var covidFetch = CovidFetchRequest()
    @ObservedObject var countryFetch = CountryDetailsFetchRequest()
    var body: some View {
        TabView {
            RecentView()
                .tabItem {Tab(imageName: "chart.bar", text: "Recent Statistics") }
            .tag(0)
            
            MapContainerView().edgesIgnoringSafeArea(.all)
                .tabItem {Tab(imageName: "map", text: "Map") }
                .tag(1)
        }
            
    }
}

private struct Tab: View {
    
    let imageName: String
    let text: String
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
            Text(text)
        }
    }
}
