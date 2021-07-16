//
//  CombineNetworkM.swift
//  APPatrika
//
//  Created by Parth Patel on 14/07/21.
//

import Foundation
import Combine

enum DataLoader {
    static func loadStores(from url: URL) -> AnyPublisher<[ArticlesModel], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: RunLoop.main)
            .map({ $0.data })
            .decode(type: [ArticlesModel].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

class DataManager: ObservableObject {
    @Published
    private(set) var appleStores = [ArticlesModel]()
    
    private var token: Cancellable?
    
    func loadStores() {
        token?.cancel()
        
        let url = URL(string: "https://timroesner.com/workshops/applestores.json")!
        token = DataLoader.loadStores(from: url)
            .sink { completion in
                if case .failure(let error) = completion {
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] result in
                self?.appleStores = result
            }
    }
}

//struct ListView: View {
//    @StateObject var dataManager = DataManager()
//
//    var body: some View {
//        List(dataManager.appleStores) { store in
//            Text(store.name)
//        }.onAppear {
//            dataManager.loadStores()
//        }
//    }
//}
