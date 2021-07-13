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
            NavigationView {
                PatrikaView()
                    .navigationBarTitle("Patrika")
            }
            .tabItem {
                Text("Patrika")
                Image(systemName: "book")
            }
            .tag(0)
            
            //2
            NavigationView {
                OutReachView()
                    .navigationBarTitle("Out Reach")
            }
            .tabItem {
                Text("Out Reach")
                Image(systemName: "books.vertical")
            }
            .tag(1)
            
            //3
            NavigationView {
                BalPatrikaView()
                    .navigationBarTitle("Bal Patrika")
            }
            .tabItem {
                Text("Bal Patrika")
                Image(systemName: "person")
            }
            .tag(2)
            
            //4
            NavigationView {
                HistoryView()
                    .navigationBarTitle("History")
            }
            .tabItem {
                Text("History")
                Image(systemName: "folder")
            }
            .tag(3)
            
            //5
            NavigationView {
                InfoView()
                    .navigationBarTitle("Info")
            }
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
