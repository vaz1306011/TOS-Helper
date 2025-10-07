//
//  EmptyTabView.swift
//  TOS Helper
//
//  Created by sora on 2025/10/7.
//

import SwiftUI

struct EmptyTabView: View {
  var onAdd: () -> Void
  var body: some View {
    Button(action: onAdd) {
      Image(systemName: "plus.circle")
        .resizable()
        .frame(width: 50, height: 50)
    }
  }
}

#Preview {
  EmptyTabView(onAdd: {})
}
