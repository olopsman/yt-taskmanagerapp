//
//  FormRowStaticBuilderView.swift
//  Cash Goals Lite
//
//  Created by Paulo Orquillo on 8/01/22.
//  Copyright © 2022 Paulo Orquilo. All rights reserved.
//

import SwiftUI

struct FormRowStaticBuilderView<Content: View>: View {
    // MARK: Properties
    
    var icon: String
    var firstText: String
    var secondText: String
    @ViewBuilder var content: Content
    
    // MARK: Body
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color.gray)
                Image(systemName: icon)
                    .foregroundColor(Color.white)
            }
            .frame(width: 36, height: 36, alignment: .center)
            Text(firstText)
                .foregroundColor(Color.gray)
                .font(.system(size: 15))
            Spacer()
            content
        }
    }
}

struct FormRowStaticBuilderView_Previews: PreviewProvider {
    static var previews: some View {
        FormRowStaticBuilderView(icon: "gear", firstText: "Application", secondText: "Todo") {
            Button(action: {
                //
            }) {
                Text("Rate this App")
                    .foregroundColor(.primary)
                    .font(.system(size: 15))
            }
        }
    }
}
