//
//  TestTab.swift
//  TOS Helper
//
//  Created by sora on 2025/9/17.
//

import SwiftUI
import WebKit

struct TestTab: View {
    let page: WebPage = WebPage()
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
    TestTab()
}
