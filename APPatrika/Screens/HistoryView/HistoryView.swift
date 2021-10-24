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
    @ObservedObject var viewModel: HistoryViewModel
    @State private var editMode = EditMode.inactive
    @State private var imageName: String = "chevron.right"
    @State private var selectedIndexs = -1
    
    var body: some View {
        switch selectedSegment {
        case .articles:
            List(viewModel.articles, id:\.self) { patrika in
                Button(action: {
                    viewModel.getDetailArticlesDirectories(for: .articles, fileName: patrika.lastPathComponent)
                    if let index = viewModel.articles.firstIndex(where: { $0 == patrika }) {
                        selectedIndexs = selectedIndexs == index ? -1 : index
                        if selectedIndexs == index {
                            imageName = "chevron.down"
                        } else {
                            imageName = "chevron.right"
                        }
                    }
                }, label: {
                    ItemRow(isRowSelected: true, titleText: patrika.lastPathComponent, imageName: $imageName)
                })
                
                if let index = viewModel.articles.firstIndex(where: { $0 == patrika }), index == selectedIndexs {
                        Section {
                            ForEach(viewModel.articlesDetails, id: \.self) { row in
                                Button(action: {
                                    self.openURL = row
                                    self.isOpenPDF = true
                                }) {
                                    ItemRow(titleText: row.lastPathComponent, imageName: $imageName)
                                }
                            }
                            .onDelete(perform: deleteArticles)
                        }
                        .padding(.leading, 20)
                }
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


    private func deleteArticles(at offSet: IndexSet) {
        if let index = offSet.first, let isDeleted = viewModel.appFileStorage.deleteFile(at: viewModel.articlesDetails[index]), isDeleted {
            viewModel.articlesDetails.remove(atOffsets: offSet)
        }
    }
}

struct ItemRow: View {
    
    var isRowSelected: Bool = false
    var titleText: String
    @Binding var imageName: String
    
    var body: some View {
        HStack {
            if isRowSelected {
                Text(self.titleText).bold()
                Spacer()
//                Image(systemName: imageName)
//                    .font(.body)
            } else {
                Text(self.titleText)
            }
            
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


struct PlaceView: View {
    let place: URL
    @State private var testData = ["1", "2", "3"]
    var body: some View {
        HStack {
            content
            Spacer()
        }
        .contentShape(Rectangle()) // 3.
    }
    
    private var content: some View {
        VStack(alignment: .leading) {
            Text(place.lastPathComponent).font(.headline)
            Spacer()
            VStack(alignment: .leading) {
                List {
                    ForEach(testData, id: \.self) { url in
                        Button(action: {
                            //viewModel.getDetailArticlesDirectories(for: .articles, fileName: url.lastPathComponent)
                        }) {
                            
                            Text(url)
                        }
                    }
                }
                //                Text("Parth")
                //                Text("place.city")
                //                Text("place.street")
                //                Text("place.zip")
                //                Text("place.phoneNumber")
            }
            Spacer()
        }
    }
}
