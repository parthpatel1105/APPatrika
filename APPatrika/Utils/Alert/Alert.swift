//
//  Alert.swift
//  APPatrika
//
//  Created by Parth Patel on 15/07/21.
//

import SwiftUI

enum AlertType: Identifiable {
    case ok(title: String, message: String? = nil)
    case singleButton(title: String, message: String? = nil, dismissButton: Alert.Button)
    case twoButtons(title: String, message: String? = nil, primaryButton: Alert.Button, secondaryButton: Alert.Button)
    
    var id: String {
        switch self {
        case .ok:
            return "ok"
        case .singleButton:
            return "singleButton"
        case .twoButtons:
            return "twoButtons"
        }
    }
    
    var alert: Alert {
        switch self {
        case .ok(title: let title, message: let message):
            return Alert(title: Text(title), message: message != nil ? Text(message!) : nil)
        case .singleButton(title: let title, message: let message, dismissButton: let dismissButton):
            return Alert(title: Text(title), message: message != nil ? Text(message!) : nil, dismissButton: dismissButton)

        case .twoButtons(title: let title, message: let message, primaryButton: let primaryButton, secondaryButton: let secondaryButton):
            return Alert(title: Text(title), message: message != nil ? Text(message!) : nil, primaryButton: primaryButton, secondaryButton: secondaryButton)
        }
    }
}



struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    
    // MARK: - Network Alert
    static let invalidData = AlertItem(title: Text("Server Error"), message: Text("The data received from the server was invalid. Please contact support."), dismissButton: .default(Text("OK")))
    
    static let invalidResponse = AlertItem(title: Text("Server Error"), message: Text("Invalid response from the server. Please try again later or contact support."), dismissButton: .default(Text("OK")))

    static let invalidURL = AlertItem(title: Text("Server Error"), message: Text("There was an issue connecting to the server. If this persists, please contact support."), dismissButton: .default(Text("OK")))

    static let unableToComplete = AlertItem(title: Text("Server Error"), message: Text("Unable to complete your request at this time. Please check your internet connection."), dismissButton: .default(Text("OK")))

}
