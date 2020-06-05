//
//  CardView.swift
//  CovidStats
//
//  Created by Isa  Selimi on 17.5.20.
//  Copyright © 2020 com.isaselimi. All rights reserved.
//

import SwiftUI

struct CardView: View {
    
    var totalNumber: String = "..."
    var title: String = "..."
    var color: Color = .primary
    
    var body: some View {
        
        GeometryReader {
            geometry in
            
            VStack {
                Text(self.totalNumber).animation(nil).lineLimit(1).minimumScaleFactor(0.5).allowsTightening(true).padding([.leading, .trailing], 5).font(.system(size: 15))
              
                Text(self.title).font(.system(size: 15)).padding(.top, 5)
                    .foregroundColor(self.color)
            }.frame(width: geometry.size.width, height: 80, alignment: .center)
                .background(Color(.systemGray6))
            .cornerRadius(10)
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
