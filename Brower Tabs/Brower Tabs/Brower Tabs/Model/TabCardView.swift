//
//  TabCardView.swift
//  Brower Tabs
//
//  Created by Chandan Kumar Dash on 23/07/24.
//
import SwiftUI

struct TabCardView: View {
    
    var tab: Tab
    @Binding var tabs: [Tab]
    @Binding var selectedTab: Tab?
    
    @State private var tabTitle = ""
    @State private var offset: CGFloat = 0
    @GestureState private var isDragging: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 10) {
            WebView(tab: tab) { title in
                self.tabTitle = title
            }
            .frame(height: 250)
            .overlay(Color.primary.opacity(0.01))
            .cornerRadius(15)
            .overlay(
                Button(action: {
                    withAnimation {
                        offset = -(getRect().width + 200)
                        removeTab()
                    }
                }, label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.primary)
                        .padding(10)
                        .background(.ultraThinMaterial, in: Circle())
                })
                .padding(10),
                alignment: .topTrailing
            )
            
            // Display tab URL at the bottom of the card
            Text(tab.tabURL)
                .fontWeight(.bold)
                .lineLimit(1)
                .frame(height: 30) // Adjust height as needed
                .padding()
                .background(Color.secondary.opacity(0.1))
                .cornerRadius(5)
                .padding(.bottom, 10)
            
            // Show tabTitle only if not in full screen
            if presentationMode.wrappedValue.isPresented {
                Text(tabTitle)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .frame(height: 50)
            }
        }
        .scaleEffect(getScale())
        .contentShape(Rectangle())
        .offset(x: offset)
        .gesture(
            DragGesture()
                .updating($isDragging, body: { _, out, _ in
                    out = true
                })
                .onChanged({ value in
                    if isDragging {
                        let translation = value.translation.width
                        offset = translation > 0 ? translation / 10 : translation
                    }
                })
                .onEnded({ value in
                    let translation = value.translation.width > 0 ? 0 : -value.translation.width
                    if getIndex() % 2 == 0 {
                        if translation > 100 {
                            withAnimation {
                                offset = -(getRect().width + 200)
                                removeTab()
                            }
                        } else {
                            withAnimation {
                                offset = 0
                            }
                        }
                    } else {
                        if translation > getRect().width - 150 {
                            withAnimation {
                                offset = -(getRect().width + 200)
                                removeTab()
                            }
                        } else {
                            withAnimation {
                                offset = 0
                            }
                        }
                    }
                })
        )
        .onTapGesture {
            withAnimation {
                selectedTab = tab
            }
        }
    }
    
    func getScale() -> CGFloat {
        let progress = (offset > 0 ? offset : -offset) / 50
        let scale = (progress < 1 ? progress : 1) * 0.08
        return 1 + scale
    }
    
    func getIndex() -> Int {
        let index = tabs.firstIndex { currentTab in
            return currentTab.id == tab.id
        } ?? 0
        return index
    }
    
    func removeTab() {
        tabs.removeAll { tab in
            return self.tab.id == tab.id
        }
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
