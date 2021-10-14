//
//  HistoryView.swift
//  APPatrika
//
//  Created by Parth Patel on 12/07/21.
//

import SwiftUI

struct HistoryView: View {
    @StateObject var viewModel = HistoryViewModel()
    
    @State private var selectedIndex: SubDirectories = .articles
    @State private var isOpenPDF: Bool = false
    @State private var openURL: URL?
    var body: some View {
        NavigationView() {
            VStack {
                SegmentView(selectedIndex: $selectedIndex)
                HistoryDisplayView(selectedSegment: $selectedIndex, isOpenPDF: $isOpenPDF, openURL: $openURL, viewModel: viewModel)
            }
            .navigationBarTitle("History")
            
            .sheet(isPresented: self.$isOpenPDF, content: {
                PDFKitView(url: self.$openURL)
            })
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}


struct SegmentView: View {
    @Binding var selectedIndex: SubDirectories
    var body: some View {
        Picker(selection: $selectedIndex, label: Text("Picker")) {
            ForEach(SubDirectories.allCases, id: \.self) {
                Text($0.dirIdentifier)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
}

struct HistoryDisplayView: View {
    
    @Binding var selectedSegment: SubDirectories
    @Binding var isOpenPDF: Bool
    @Binding var openURL: URL?
    var displayArray: [String] = ["1", "2", "3"]
    @ObservedObject var viewModel: HistoryViewModel
    @State private var editMode = EditMode.inactive
    
    var body: some View {
        switch selectedSegment {
        case .articles:
            List {
                ForEach(viewModel.articles, id: \.self) { url in
                    Button(action: {
//                        if let urls = viewModel.appFileStorage.listDirectories(directory: url), urls.count > 0 {
//                            self.openURL = urls[0]
//                            self.isOpenPDF = true
//                        }
                    }) {
                        Text(url.lastPathComponent)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(PlainListStyle())
            .navigationBarItems(trailing: EditButton())
            .onAppear {
                viewModel.getArticlesDirectories(for: .articles)
            }
        case .balPatrika:
            List {
                ForEach(viewModel.balPatrika, id: \.self) { url in
                    Button(action: {
                        if let urls = viewModel.appFileStorage.listDirectories(directory: url), urls.count > 0 {
                            self.openURL = urls[0]
                            self.isOpenPDF = true
                        }
                        
                    }) {
                            Text(url.lastPathComponent)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(PlainListStyle())
            .navigationBarItems(trailing: EditButton())
            .onAppear {
                viewModel.getBalPatrikaDirectories(for: .balPatrika)
            }
        }
    }
    
    private func deleteItems(at offSet: IndexSet) {
        if let index = offSet.first, let isDeleted = viewModel.appFileStorage.deleteFile(at: viewModel.balPatrika[index]), isDeleted {
            viewModel.balPatrika.remove(atOffsets: offSet)
        }
        
    }
}


@available(iOS 14.0, *)
struct ItemsToolbar: ToolbarContent {
    let add: () -> Void
    let sort: () -> Void

    
    var body: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button("Add", action: add)
        }

        ToolbarItem(placement: .bottomBar) {
            Button("Sort", action: sort)
        }
    }
}
