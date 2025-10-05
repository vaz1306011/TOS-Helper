//
//  TestTab.swift
//  TOS Helper
//
//  Created by sora on 2025/9/17.
//

import SwiftUI
import WebKit

    let page: WebPage = WebPage()
struct TestTabView: View {
    var body: some View {
        NavigationStack {
            WebView(page)
                .onAppear {
                    page.load(URLRequest(url:URL(string:"https://hiteku.github.io/tosPath/")!))
                }
                .navigationTitle(Text("TOS Path"))
        }
    }
}

#Preview {
    TestTabView()
}
