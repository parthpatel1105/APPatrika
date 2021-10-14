//
//  CustomTabView.swift
//  APPatrika
//
//  Created by Parth Patel on 12/07/21.
//

import SwiftUI

enum Tab {
    case patrika
    case balPatrika
    case history
    case info
}

class TabController: ObservableObject {
    @Published var activeTab = Tab.patrika
    
    func open(_ tab: Tab) {
        activeTab = tab
    }
}

struct CustomTabView: View {
    
    // MARK: - Properties
    @StateObject private var tabController = TabController()
    @Environment(\.colorScheme) var colorScheme
    
    // MARK: - Body
    var body: some View {
        TabView(selection: $tabController.activeTab) {
            //1
            ArticleListView()
            .tabItem {
                Text("Patrika")
                Image(systemName: "book")
            }
            .tag(Tab.patrika)
            
            //2
            BalPatrikaView()
            .tabItem {
                Text("Bal Patrika")
                Image(systemName: "person")
            }
            .tag(Tab.balPatrika)
            
            //3
            HistoryView()
            .tabItem {
                Text("History")
                Image(systemName: "folder")
            }
            .tag(Tab.history)
            
            //4
            InfoView()
            .tabItem {
                Text("Info")
                Image(systemName: "info.circle")
            }
            .tag(Tab.info)
            
        }
        .accentColor(colorScheme == .dark ? .white : .black)
        .environmentObject(tabController)
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView()
    }
}
