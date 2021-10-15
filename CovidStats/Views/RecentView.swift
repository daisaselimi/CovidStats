//
//  RecentView.swift
//  CovidStats
//
//  Created by Isa  Selimi on 17.5.20.
//  Copyright © 2020 com.isaselimi. All rights reserved.
//

import SwiftUI

struct RecentView: View {
    
    @EnvironmentObject var covidFetch: CovidFetchRequest
    @ObservedObject var countryFetch = CountryDetailsFetchRequest()
    @State var searchText = ""
    @State var isSearchVisible = false
    @State var didTapTableHeader = false
    
    var body: some View {
        NavigationView {
            VStack {
                if self.isSearchVisible && !self.didTapTableHeader {
                    SearchView(searchText: self.$searchText).onTapGesture {
                        UIApplication.shared.windows
                            .first { $0.isKeyWindow }?
                            .endEditing(true)
                    }
                } else  if !self.didTapTableHeader && !self.isSearchVisible {
                    TotalsView(totalsData: self.covidFetch.totalData).padding(10)
                }
                
                VStack(spacing: 5){
                    ListHeaderView()
                        .gesture(DragGesture(minimumDistance: 30, coordinateSpace: .local).onEnded({ (value) in
                        if value.translation.height < 0 {
                            if !self.isSearchVisible {
                                withAnimation(.easeIn(duration: 0.2)) {
                                    self.didTapTableHeader = true
                                }
                            }
                            
                        } else if value.translation.height > 0 {
                            withAnimation(.easeIn(duration: 0.2)) {
                                self.didTapTableHeader = false
                            }
                        }
                    })).frame(height: 40)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(self.covidFetch.allCountries.filter {
                            self.searchText.isEmpty ? true : $0.country.lowercased().contains(self.searchText.lowercased()) }
                        , id: \.country) { countryData in
                            NavigationLink(destination: CountryDetailsView(countryName: countryData.country, countryData: countryData)) {
                                CountryDataRow(countryData: countryData)
                            }  
                        }
                    }
                }
            }
            .navigationBarTitle("Recents", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    withAnimation(.easeOut(duration: 0.2)) {
                        self.isSearchVisible.toggle()
                        self.didTapTableHeader = false
                    }
                    if !self.isSearchVisible {
                        self.searchText = ""
                    }
                }, label: {
                    if !self.isSearchVisible {
                        Image(systemName: "magnifyingglass")
                    } else {
                        Image(systemName: "chart.bar.fill")
                    }
                }).padding()
            )
        }
    }
}

struct RecentView_Previews: PreviewProvider {
    static var previews: some View {
        RecentView()
    }
}
