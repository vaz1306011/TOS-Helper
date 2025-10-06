//
//  AddTabView.swift
//  TOS Helper
//
//  Created by sora on 2025/10/6.
//

import SwiftUI

struct AddTabView: View {
  var onSave: (GameData) -> Void
  var onCancel: () -> Void

  @State private var gameData: GameData = .init(name: "", recoveryInterval: 8)

  var body: some View {
    NavigationStack {
      Form {
        Section(header: Text("game_name")) {
          TextField("game_name", text: $gameData.name)
        }
        Section(header: Text("recovery_interval")) {
          TextField(
            "game_name",
            value: $gameData.recoveryInterval,
            format: .number
          )
        }
      }
      .navigationTitle("add_timer")
      .toolbar {
        ToolbarItem(placement: .confirmationAction) {
          Button("save") {
            onSave(gameData)
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
  AddTabView(onSave: { _ in }, onCancel: {})
}
