//
//  InfoView.swift
//  APPatrika
//
//  Created by Parth Patel on 12/07/21.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.captionBackgroundColor) var backgroundColor
    
    var body: some View {
        NavigationView {
            Text("Hello, Info!")
                .background(backgroundColor)
                .navigationBarTitle("Info")
        }        
        
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}

private struct CaptionColorKey: EnvironmentKey {
    static let defaultValue = Color(.secondarySystemBackground)
}

extension EnvironmentValues {
    var captionBackgroundColor: Color {
        get { self[CaptionColorKey.self] }
        set { self[CaptionColorKey.self] = newValue }
    }
}

extension View {
    func captionBackgroundColor(_ color: Color) -> some View {
        environment(\.captionBackgroundColor, color)
    }
}
