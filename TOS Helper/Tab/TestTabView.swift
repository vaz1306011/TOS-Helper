//
//  TestTab.swift
//  TOS Helper
//
//  Created by sora on 2025/9/17.
//

import SwiftUI
import WebKit

struct TestTabView: View {
  // MARK: - Properties
  private let page: WebPage = .init()

  // MARK: - Body
  var body: some View {
    NavigationStack {
      WebView(page)
        .onAppear {
          page.load(
            URLRequest(url: URL(string: "https://hiteku.github.io/tosPath/")!)
          )
        }
        .navigationTitle(Text("TOS Path"))
    }
  }
}

// MARK: - Preview
#Preview {
  TestTabView()
}
