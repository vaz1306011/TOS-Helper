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
                TimerTab()
            }
            Tab("固版轉法", systemImage: "wand.and.outline"){
                TestTab()
            }
        }
        .tabBarMinimizeBehavior(.onScrollDown)
    }
}

#Preview {
    ContentView()
}
