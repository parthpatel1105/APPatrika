//
//  HistoryView.swift
//  APPatrika
//
//  Created by Parth Patel on 12/07/21.
//

import SwiftUI

struct HistoryView: View {
    @StateObject var viewModel = HistoryViewModel()
    
    @State private var selectedIndex = 0
    @State private var array = [1,2,3,4]
    var body: some View {
        NavigationView() {
            VStack {
                SegmentView(selectedIndex: $selectedIndex)
                List(selectedIndex == 0 ? viewModel.articles : viewModel.testArticles) { article in
                   ArticleListCell(article: article)
                }
                .listStyle(PlainListStyle())
                
            }
            .navigationBarTitle("History")
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}


struct SegmentView: View {
    @Binding var selectedIndex: Int
    var body: some View {
        Picker(selection: $selectedIndex, label: Text("Picker")) {
            Text("Patrika").tag(0)
            Text("Out Reach").tag(1)
            Text("BalPatrika").tag(2)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
}
