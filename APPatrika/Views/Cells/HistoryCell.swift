//
//  HistoryCell.swift
//  APPatrika
//
//  Created by Parth Patel on 24/09/21.
//

import SwiftUI

struct HistoryCell: View {
    var title: String
    var body: some View {
        HStack {
            Text(title)
        }
    }
}

struct HistoryCell_Previews: PreviewProvider {
    static var previews: some View {
        HistoryCell(title: "")
    }
}
