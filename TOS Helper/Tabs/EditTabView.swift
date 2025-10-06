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
        TextField("game_name", text: $tab.name)
      }
      .navigationTitle("edit_timer")
      .toolbar {
        ToolbarItem(placement: .confirmationAction) {
          Button("save") {
            onSave(tab)
          }
        }
        ToolbarItem(placement: .cancellationAction) {
          Button("cancel") {
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
      tab: GameTab(name: "Test name", view: TimerTabView()),
      onSave: { _ in },
      onCancel: {}
    )
  }
}
