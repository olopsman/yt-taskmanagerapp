//
//  SettingsView.swift
//  TaskManagementApp
//
//  Created by Paulo Orquillo on 10/12/2024.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            VStack {
                //MARK: Form Control
                Form {
                    //MARK: App Info
                    Section {
                        HStack {
                            Image("net-worth")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 70)
                                .cornerRadius(15)
                            
                            VStack(alignment: .leading) {
                                Text(AppInfo.appName)
                                    .fontWeight(.semibold)
                                Text("Version \(AppInfo.version)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        FormRowStaticView(icon: "checkmark.seal", firstText: "Compatibility", secondText: "iPhone, iPad")
                        FormRowStaticView(icon: "keyboard", firstText: "Company", secondText: AppInfo.company)
                        FormRowStaticView(icon: "terminal", firstText: "Developer", secondText: AppInfo.developer)
                        FormRowLinkView(icon: "globe", color: Color.pink, text: "Contact Us", link: "https://www.quonsepto.com/#contact")
                        FormRowLinkView(icon: "link", color: Color.blue, text: "Twitter", link: "https://twitter.com/quonsepto")
                            .padding(.top, 2)
                        Button(action: {
                            guard let writeReviewURL = URL(string: "https://apps.apple.com/nz/app/net-worth-progress-tracker/id1611891442?action=write-review")
                            else { fatalError("Expected a valid URL") }
                            UIApplication.shared.open(writeReviewURL)
                        }){
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                                        .fill(.gray.opacity(0.1))
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                }
                                .frame(width: 36, height: 36, alignment: .center)
                                
                                Text("Write a review")
                                    .foregroundColor(.gray)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                                
                            }
                        }
                    } header: {
                        Text("About the App")
                            .textCase(nil)
                            .fontWeight(.semibold)
                    }
                    .padding(.vertical, 3)
                    Button("Restore Purchases", action: {
//                        Task {
//                            //This call displays a system prompt that asks users to authenticate with their App Store credentials.
//                            //Call this function only in response to an explicit user action, such as tapping a button.
//                            //                            try? await AppStore.sync()
//                        }
                    })
                }
            }
        }
        
    }
}

#Preview {
    SettingsView()
}
