//
//  CustomTabView.swift
//  APPatrika
//
//  Created by Parth Patel on 12/07/21.
//

import SwiftUI

struct CustomTabView: View {
    
    // MARK: - Properties
    
    @Environment(\.colorScheme) var colorScheme
    
    // MARK: - Body
    var body: some View {
        TabView {
            //1
            ArticleListView()
            .tabItem {
                Text("Patrika")
                Image(systemName: "book")
            }
            .tag(0)
            
            //2
            OutReachView()
            .tabItem {
                Text("Out Reach")
                Image(systemName: "books.vertical")
            }
            .tag(1)
            
            //3
            BalPatrikaView()
            .tabItem {
                Text("Bal Patrika")
                Image(systemName: "person")
            }
            .tag(2)
            
            //4
            HistoryView()
            .tabItem {
                Text("History")
                Image(systemName: "folder")
            }
            .tag(3)
            
            //5
            InfoView()
            .tabItem {
                Text("Info")
                Image(systemName: "info.circle")
            }
            .tag(4)
            
        }.accentColor(colorScheme == .dark ? .white : .black)
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView()
    }
}
