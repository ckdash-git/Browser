//
//  FullScreenContainerView.swift
//  Brower Tabs
//
//  Created by Chandan Kumar Dash on 29/07/24.
//

import SwiftUI
import WebKit

struct FullScreenContainerView: View {
    var tab: Tab
    var openNewTab: (Tab) -> Void
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Done")
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding()
            }
            
            FullScreenView(tab: tab, openNewTab: openNewTab)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    FullScreenContainerView(tab: Tab(tabURL: "https://cap01.cachatto.co.in/urls/index.jsp"), openNewTab: { _ in })
        .preferredColorScheme(.dark)
}
