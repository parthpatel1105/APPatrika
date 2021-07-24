//
//  PDFKitView.swift
//  APPatrika
//
//  Created by Parth Patel on 19/07/21.
//

import SwiftUI
import PDFKit
struct PDFKitView: View {
    @Binding var url: URL?
    var body: some View {
        if let url = self.url {
            PDFKitRepresentedView(url)
        }
        
    }
}

struct PDFKitRepresentedView: UIViewRepresentable {
    let url: URL
    init(_ url: URL) {
        self.url = url
    }

    func makeUIView(context: UIViewRepresentableContext<PDFKitRepresentedView>) -> PDFKitRepresentedView.UIViewType {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: self.url)
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PDFKitRepresentedView>) {
        // Update the view.
    }
}
