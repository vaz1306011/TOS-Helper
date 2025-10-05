//
//  ContentView.swift
//  TOS Helper
//
//  Created by sora on 2025/9/17.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            Tab("計時器", systemImage: "timer"){
                TimerTabView()
            }
            Tab("固版轉法", systemImage: "wand.and.outline"){
                TestTabView()
            }
        }
        .tabBarMinimizeBehavior(.onScrollDown)
    }
}

#Preview {
    ContentView()
}
