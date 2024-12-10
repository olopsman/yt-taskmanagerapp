//
//  FormRowLinkView.swift
//  Cash Goals Lite
//
//  Created by Paulo Orquillo on 8/01/22.
//  Copyright © 2022 Paulo Orquilo. All rights reserved.
//

import SwiftUI

struct FormRowLinkView: View {
    // MARK: Properties
    
    var icon: String
    var color: Color
    var text: String
    var link: String
    
    // MARK: Body
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(color)
                if icon == "link" || icon == "globe" {
                    Image(systemName: icon)
                        .imageScale(.large)
                        .foregroundColor(Color.white)
                } else {
                    Image(icon)
                        .resizable()
                        .imageScale(.large)
                        .foregroundColor(Color.white)
                        .cornerRadius(5)
                }
            }.frame(width: 36, height: 36, alignment: .center)
            
            Text(text).foregroundColor(Color.gray)
                .font(.system(size: 15))
            Spacer()
            Button(action: {
                //open a link
                guard let url = URL(string: self.link), UIApplication.shared.canOpenURL(url) else {
                    return
                }
                UIApplication.shared.open(url as URL)
                
            }) {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .accentColor(Color(.systemGray2))
            }
        }
    }
}

struct FormRowLinkView_Previews: PreviewProvider {
    static var previews: some View {
        FormRowLinkView(icon: "globe", color: Color.pink, text: "Website", link: "https://lopau.com")
            .previewLayout(.fixed(width: 375, height: 60))
            .padding()
    }
}

