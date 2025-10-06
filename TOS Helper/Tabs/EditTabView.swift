//
//  EditTabView.swift
//  TOS Helper
//
//  Created by sora on 2025/10/6.
//

import SwiftUI

struct EditTabView: View {
  @State var tab: GameTab
  var onSave: (GameTab) -> Void
  var onCancel: () -> Void
  
  var body: some View {
    NavigationStack {
      Form {
        TextField("Tab 名稱", text: $tab.name)
      }
      .navigationTitle("編輯 Tab")
      .toolbar {
        ToolbarItem(placement: .confirmationAction) {
          Button("完成") {
            onSave(tab)
          }
        }
        ToolbarItem(placement: .cancellationAction) {
          Button("取消") {
            onCancel()
          }
        }
      }
    }
  }
}

#Preview {
  NavigationStack {
    EditTabView(
      tab: GameTab(name: "計時器", view: TimerTabView()),
      onSave: { _ in },
      onCancel: {}
    )
  }
}
