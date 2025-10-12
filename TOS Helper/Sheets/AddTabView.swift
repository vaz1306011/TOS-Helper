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
  var onComplete: (() -> Void)?

  @State private var gameData: GameData = .init("", recoveryInterval: 8)

  var body: some View {
    NavigationStack {
      Form {
        Section(header: Text("game_name")) {
          TextField("game_name", text: $gameData.name)
        }
        Section(header: Text("recovery_interval")) {
          TextField(
            "game_name",
            value: $gameData.staminaManager.recoveryInterval,
            format: .number
          )
        }
      }
      .navigationTitle("add_timer")
      .toolbar {
        ToolbarItem(placement: .confirmationAction) {
          Button {
            onSave(gameData)
            onComplete?()
          } label: {
            Image(systemName: "checkmark")
          }
          .disabled(!isNameValid() || !isRecoveryIntervalValid())
        }
        ToolbarItem(placement: .cancellationAction) {
          Button {
            onCancel()
            onComplete?()
          } label: { Image(systemName: "xmark") }
        }
      }
    }
  }
}

// MARK: - Check Logic
private extension AddTabView {
  func isNameValid() -> Bool {
    !gameData.name.isEmpty
  }

  func isRecoveryIntervalValid() -> Bool {
    let recoveryInterval = gameData.staminaManager.recoveryInterval
    return recoveryInterval > 0 && recoveryInterval.isMultiple(of: 1)
  }
}

// MARK: - Preview
#Preview {
  AddTabView(onSave: { _ in }, onCancel: {})
}
