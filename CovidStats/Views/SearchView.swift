//
//  SearchView.swift
//  CovidStats
//
//  Created by Isa  Selimi on 17.5.20.
//  Copyright © 2020 com.isaselimi. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        
        HStack {
            CustomTextField(text: $searchText, isFirstResponder: true)
                .padding()
            
            if searchText != "" {
                Button(action: {
                    self.searchText = ""
                }, label: {
                    Image(systemName: "xmark")
                }).padding()
            }
        }
        .frame(height: 50)
        .background(Color(.systemGray6)).cornerRadius(50).padding(.leading, 20).padding(.trailing, 20).padding(.top, 10)
    }
}
