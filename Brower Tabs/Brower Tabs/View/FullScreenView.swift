//
//  FullScreenView.swift
//  Brower Tabs
//
//  Created by Chandan Kumar Dash on 22/07/24.
//

//import SwiftUI
//
//struct FullScreenView: View {
//    var tab: Tab
//    
//    @Environment(\.presentationMode) var presentationMode
//    
//    @State private var tabTitle: String = ""
//    
//    var body: some View {
//        VStack {
//            HStack {
//                Button(action: {
//                    presentationMode.wrappedValue.dismiss()
//                }, label: {
//                    Image(systemName: "chevron.left")
//                        .font(.title2)
//                        .padding()
//                })
//                Spacer()
//                Text(tabTitle)
//                    .font(.headline)
//                    .padding()
//                Spacer()
//            }
//            
//            WebView(tab: tab) { title in
//                self.tabTitle = title
//            }
//            .cornerRadius(15)
//            .edgesIgnoringSafeArea(.bottom)
//        }
//    }
//}

import SwiftUI
import WebKit

struct FullScreenView: UIViewRepresentable {
    var tab: Tab
    var openNewTab: (Tab) -> Void
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        if let url = URL(string: tab.tabURL) {
            webView.load(URLRequest(url: url))
        }
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: FullScreenView
        
        init(_ parent: FullScreenView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let url = navigationAction.request.url, navigationAction.navigationType == .linkActivated {
                decisionHandler(.cancel)
                parent.openNewTab(Tab(tabURL: url.absoluteString))
                
                //Here I have to work for presenting the new opened tab
                
            } else {
                decisionHandler(.allow)
            }
        }
    }
}


/* FullScreenContainer */


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
                        .foregroundColor(.blue)
                        .padding(8)
//                        .background(Color.blue)
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
