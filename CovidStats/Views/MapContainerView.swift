//
//  MapContainerView.swift
//  CovidStats
//
//  Created by Isa  Selimi on 18.5.20.
//  Copyright © 2020 com.isaselimi. All rights reserved.
//

import SwiftUI

struct MapContainerView: View {
    
    @EnvironmentObject var covidFetch: CovidFetchRequest
    @State var filterBy: String = "Recovered"
    
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            MapView(countryData: $covidFetch.allCountries, filterBy: filterBy)
            FilterMapAnnotationsView(filterBy: $filterBy).padding()
            
        }
        
    }
}

struct FilterMapAnnotationsView: View {
    
    let statusBarHeight: CGFloat = {
        var heightToReturn: CGFloat = 0.0
        for window in UIApplication.shared.windows {
            if let height = window.windowScene?.statusBarManager?.statusBarFrame.height, height > heightToReturn {
                heightToReturn = height
            }
        }
        return heightToReturn
    }()
    
    @Binding var filterBy: String
    @State private var currentPosition: CGSize = .zero
    @State private var newPosition: CGSize = .zero
    
    var body: some View {
        
        ZStack(alignment: .center) {
            
            VStack(alignment: .leading, spacing: 5) {
                
                Text("Filter by").font(.system(size: 12)).foregroundColor(Color(.systemRed))
                
                Divider().background(Color.white).opacity(0.5)
                
                Button(action: { self.filterBy = "Recovered" }, label: {
                    Text("Recovered").font(.system(size: 12)).foregroundColor(self.filterBy == "Recovered" ? Color(.label) : .gray)
                })
                    .disabled(self.filterBy == "Recovered")
                
                Button(action: { self.filterBy = "Deaths" }, label: {
                    Text("Deaths").font(.system(size: 12)).foregroundColor(self.filterBy == "Deaths" ? Color(.label) : .gray)
                })
                    .disabled(self.filterBy == "Deaths")
            }
            .padding()
            .background(Blur())
            .cornerRadius(20)
        }
        .frame(width: 100, height: 100)
        .offset(x: currentPosition.width, y: currentPosition.height)
        .gesture(DragGesture()
        .onChanged { value in
            self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width, height: value.translation.height + self.newPosition.height)
        }   // 4.
            .onEnded { value in
                self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width, height: value.translation.height + self.newPosition.height)
  
                self.newPosition = self.currentPosition
                              print(self.newPosition.width)
                print(self.newPosition.height)
            }
        )
            .onAppear {
                
                self.currentPosition = CGSize(width: 0, height: self.statusBarHeight)
                self.newPosition = self.currentPosition
        }
        
    }
}

struct MapContainerView_Previews: PreviewProvider {
    static var previews: some View {
        MapContainerView()
    }
}

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .regular
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
