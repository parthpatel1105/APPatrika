//
//  LoadingView.swift
//  APPatrika
//
//  Created by Parth Patel on 15/07/21.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.color = .systemGray
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        
    }
    
}


struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            
            ActivityIndicator()
        }
    }
}


struct CustomProgressView: View {
    @EnvironmentObject var dataModel: PDFDownloader
    //@Binding var progress: Float
    
    //@State private var progress: CGFloat = 0.20

    var body: some View {
  
        ZStack {
            // 3.
            Circle()
                .stroke(Color.gray, lineWidth: 5)
                .opacity(0.1)
            // 4.
            Circle()
                .trim(from: 0, to: CGFloat(dataModel.progress))
                .stroke(Color.red, lineWidth: 5)
                .rotationEffect(.degrees(-90))
                // 5.
                .overlay(
                    Text(dataModel.progressText))
                .font(.subheadline)
            
        }.padding(20)
        .frame(height: 100)
        
        
        
//        VStack(spacing: 20){
//            // 2.
////            HStack {
////                Text("0%")
////                Slider(value: $progress)
////                Text("100%")
////            }.padding()
//
//
//            Spacer()
//        }
    }
    
    
    
    
//    var body: some View {
//        VStack(alignment: .leading) {
//            //Text("\(Int(vm.fractionCompleted * 100))% completed")
//            Text("100% Completed")
//            ZStack {
//                RoundedRectangle(cornerRadius: 2)
//                    .foregroundColor(Color(UIColor.systemGray5))
//                    .frame(height: 4)
//                GeometryReader { metrics in
//                    RoundedRectangle(cornerRadius: 2)
//                        .foregroundColor(.blue)
//                        .frame(width: metrics.size.width * CGFloat(10))
//                }
//            }.frame(height: 4)
////            Text("\(vm.progress.completedUnitCount) of \(vm.progress.totalUnitCount)")
////                .font(.footnote)
////                .foregroundColor(.gray)
//        }
//    }
}
