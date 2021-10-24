//
//  BalPatrikaListCell.swift
//  APPatrika
//
//  Created by Parth Patel on 17/07/21.
//

import SwiftUI

struct BalPatrikaListCell: View {
    let balPatrika: BalPatrikaModel
    
    var body: some View {
        HStack {
//            ArticleRemoteImage(urlString: "\(balPatrika.bPID)/" + balPatrika.bPFile)
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 70, height: 70)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(balPatrika.bPTitle)
                    .font(.system(size: 17))
                    .fontWeight(.regular)
                Text(balPatrika.bPDate)
                    .font(.subheadline)
                    .fontWeight(.light)
            }
            .padding(.leading)
        }
    }
}

struct BalPatrikaListCell_Previews: PreviewProvider {
    static var previews: some View {
        BalPatrikaListCell(balPatrika: MockData.sampleBalPatrika)
    }
}


