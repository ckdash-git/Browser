//
//  Home.swift
//  Browser Tabs
//
//  Created by Chandan Kumar Dash on 22/07/24.
//

//import SwiftUI
//
//struct Home: View {
//    
//    // Color Scheme
//    @Environment(\.colorScheme) var scheme
//    
//    // Sample Tabs for demo
//    @State var tabs: [Tab] = [
//        .init(tabURL: "https://cap01.cachatto.co.in/urls/index.jsp")
//    ]
//    
//    @State private var selectedTab: Tab?
//    @State private var isDropDownExpanded: Bool = false
//    
//    var body: some View {
//        ZStack {
//            // Background...
//            GeometryReader { proxy in
//                let size = proxy.size
//                Image("BG")
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: size.width, height: size.height)
//                    .cornerRadius(0)
//            }
//            .overlay((scheme == .dark ? Color.black : Color.white).opacity(0.35))
//            .overlay(.ultraThinMaterial)
//            .ignoresSafeArea()
//            
//            ScrollView(.vertical, showsIndicators: false) {
//                // Lazy Grids...
//                let columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
//                
//                LazyVGrid(columns: columns, spacing: 15) {
//                    // Tabs...
//                    ForEach(tabs) { tab in
//                        // Tab card view...
//                        TabCardView(tab: tab, tabs: $tabs, selectedTab: $selectedTab)
//                    }
//                }
//                .padding()
//            }
//            .safeAreaInset(edge: .bottom) {
//                VStack(spacing: 0) {
//                    HStack {
//                        Button {
//                            withAnimation {
//                                tabs.append(Tab(tabURL: "https://cap01.cachatto.co.in/urls/index.jsp"))
//                            }
//                        } label: {
//                            Image(systemName: "plus")
//                                .font(.title2)
//                        }
//                        Spacer()
//                        Button {
//                            withAnimation {
//                                isDropDownExpanded.toggle()
//                            }
//                        } label: {
//                            Text("Done")
//                                .fontWeight(.semibold)
//                        }
//                    }
//                    .overlay(
//                        Button(action: {
//                            withAnimation {
//                                isDropDownExpanded.toggle()
//                            }
//                        }) {
//                            Text("Tabs: \(tabs.count)")
//                                .fontWeight(.semibold)
//                                .foregroundColor(.primary)
//                        }
//                    )
//                    .padding([.horizontal, .top])
//                    .padding(.bottom, 10)
//                    .background(
//                        scheme == .dark ? Color.black : Color.white
//                    )
//                    
//                    if isDropDownExpanded {
//                        VStack {
//                            ScrollView {
//                                VStack {
//                                    ForEach(tabs) { tab in
//                                        Text(tab.tabURL)
//                                            .padding(.vertical, 5)
//                                            .padding(.horizontal)
//                                            .background(Color.secondary.opacity(0.1))
//                                            .cornerRadius(5)
//                                    }
//                                }
//                                .padding()
//                                .background(Color.secondary.opacity(0.2))
//                                .cornerRadius(10)
//                                .padding([.horizontal, .bottom])
//                            }
//                            .frame(maxHeight: 200) // Limit the height of the scroll view
//                            .background(scheme == .dark ? Color.black : Color.white) // Add a solid background to the dropdown
//                            .cornerRadius(10)
//                            .padding(.horizontal)
//                            .frame(maxWidth: .infinity) // Make the dropdown cover the full width
//                        }
//                        .transition(.move(edge: .bottom)) // Smooth transition effect
//                        .animation(.easeInOut) // Animation for dropdown
//                    }
//                }
//                .background(scheme == .dark ? Color.black : Color.white) // Ensure full width background
//            }
//        }
//        .fullScreenCover(item: $selectedTab) { tab in
//            FullScreenView(tab: tab)
//        }
//    }
//}
//
//#Preview {
//    Home()
//        .preferredColorScheme(.dark)
//}
//
///* Don't change anything on this Preview*/

import SwiftUI
import WebKit

struct Home: View {
    
    // Color Scheme
    @Environment(\.colorScheme) var scheme
    
    // Sample Tabs for demo
    @State var tabs: [Tab] = [
        .init(tabURL: "https://cap01.cachatto.co.in/urls/index.jsp")
    ]
    
    @State private var selectedTab: Tab?
    @State private var isDropDownExpanded: Bool = false
    
    var body: some View {
        ZStack {
            // Background...
            GeometryReader { proxy in
                let size = proxy.size
                Image("BG")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height)
                    .cornerRadius(0)
            }
            .overlay((scheme == .dark ? Color.black : Color.white).opacity(0.35))
            .overlay(.ultraThinMaterial)
            .ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                // Lazy Grids...
                let columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
                
                LazyVGrid(columns: columns, spacing: 15) {
                    // Tabs...
                    ForEach(tabs) { tab in
                        // Tab card view...
                        TabCardView(tab: tab, tabs: $tabs, selectedTab: $selectedTab)
                    }
                }
                .padding()
            }
            .safeAreaInset(edge: .bottom) {
                VStack(spacing: 0) {
                    HStack {
                        Button {
                            withAnimation {
                                tabs.append(Tab(tabURL: "https://cap01.cachatto.co.in/urls/index.jsp"))
                            }
                        } label: {
                            Image(systemName: "plus")
                                .font(.title2)
                        }
                        Spacer()
                        Button {
                            withAnimation {
                                isDropDownExpanded.toggle()
                            }
                        } label: {
                            Text("Done")
                                .fontWeight(.semibold)
                        }
                        
                        //
                    }
                    .overlay(
                        Button(action: {
                            withAnimation {
                                isDropDownExpanded.toggle()
                            }
                        }) {
                            Text("Tabs: \(tabs.count)")
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                        }
                    )
                    .padding([.horizontal, .top])
                    .padding(.bottom, 10)
                    .background(
                        scheme == .dark ? Color.black : Color.white
                    )
                    
                    if isDropDownExpanded {
                        VStack {
                            ScrollView {
                                VStack {
                                    ForEach(tabs) { tab in
                                        Text(tab.tabURL)
                                            .padding(.vertical, 5)
                                            .padding(.horizontal)
                                            .background(Color.secondary.opacity(0.1))
                                            .cornerRadius(5)
                                    }
                                }
                                .padding()
                                .background(Color.secondary.opacity(0.2))
                                .cornerRadius(10)
                                .padding([.horizontal, .bottom])
                            }
                            .frame(maxHeight: 200) // Limit the height of the scroll view
                            .background(scheme == .dark ? Color.black : Color.white) // Add a solid background to the dropdown
                            .cornerRadius(10)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity) // Make the dropdown cover the full width
                        }
                        .transition(.move(edge: .bottom)) // Smooth transition effect
                        .animation(.easeInOut) // Animation for dropdown
                    }
                }
                .background(scheme == .dark ? Color.black : Color.white) // Ensure full width background
            }
        }
        .fullScreenCover(item: $selectedTab) { tab in
            FullScreenContainerView(tab: tab, openNewTab: { newTab in
                tabs.append(newTab)
                selectedTab = newTab  // Display the newly opened tab
            })
        }
    }
}

#Preview {
    Home()
        .preferredColorScheme(.dark)
}
