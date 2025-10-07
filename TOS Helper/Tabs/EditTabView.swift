//
//  EditTabView.swift
//  TOS Helper
//
//  Created by sora on 2025/10/6.
//

import SwiftUI

struct EditTabView: View {
  // MARK: - Properties
  @Binding var gameData: GameData
  var onSave: () -> Void
  var onCancel: () -> Void

  @State private var tempGameData: GameData

  // MARK: - Init
  init(
    gameData: Binding<GameData>,
    onSave: @escaping () -> Void,
    onCancel: @escaping () -> Void
  ) {
    self._gameData = gameData
    self.onSave = onSave
    self.onCancel = onCancel
    self.tempGameData = gameData.wrappedValue
  }

  // MARK: - Body
  var body: some View {
    NavigationStack {
      Form {
        Section(header: Text("game_name")) {
          TextField("game_name", text: $tempGameData.name)
        }
        Section(header: Text("recovery_interval")) {
          TextField(
            "game_name",
            value: $tempGameData.recoveryInterval,
            format: .number
          )
        }
      }
      .navigationTitle("edit_timer")
      .toolbar {
        ToolbarItem(placement: .confirmationAction) {
          Button("save") {
            gameData = tempGameData
            onSave()
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

// MARK: - Preview
#Preview {
  EditTabView(
    gameData: .constant(GameData("", recoveryInterval: 8)),
    onSave: {},
    onCancel: {}
  )
}
