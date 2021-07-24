//
//  BalPatrikaViewModel.swift
//  APPatrika
//
//  Created by Parth Patel on 17/07/21.
//

import Foundation

final class BalPatrikaViewModel: ObservableObject {
    
    @Published var balPatrikas: [BalPatrikaModel] = []
    @Published var alertType: AlertType? = nil
    @Published var isLoading = false
    lazy var fileManager = FileManager()
    
    func getBalPatrika() {
        isLoading = true
        NetworkManager.shared.fetchAPI(request: APIEndpoint.getBalPatrika.getURLRequest()) { [weak self] (result: Result<[BalPatrikaModel], ErrorMessage>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let balPatrikas):
                    self.balPatrikas = balPatrikas
                case .failure(let error):
                    Logger.log(error.localizedDescription)
                    self.showError(error: error)
                }
            }
            
        }
    }
    
    
    // MARK: - HandleAPI Errors
    private func showError(error: ErrorMessage) {
        switch error {
        case .invalidResponse:
            self.alertType = .ok(title: "Server Error", message: "Invalid response from the server. Please try again later or contact support.")
        case .invalidData:
            self.alertType = .ok(title: "Server Error", message: "The data received from the server was invalid. Please contact support.")
        case .unableToComplete:
            self.alertType = .ok(title: "Server Error", message: "Unable to complete your request at this time. Please check your internet connection.")
        case .invalidURL:
            self.alertType = .ok(title: "Server Error", message: "There was an issue connecting to the server. If this persists, please contact support.")
        }
    }

}
