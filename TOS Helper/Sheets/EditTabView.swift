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
  var onComplete: (() -> Void)?

  @State private var tempGameData: GameData

  @State private var showCancelAlert: Bool = false
  @State private var currentDetent = PresentationDetent.large

  // MARK: - Init
  init(
    gameData: Binding<GameData>,
    onSave: @escaping () -> Void,
    onCancel: @escaping () -> Void,
    onComplete: @escaping () -> Void = {}
  ) {
    self._gameData = gameData
    self.onSave = onSave
    self.onCancel = onCancel
    self.onComplete = onComplete
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
            "recovery_interval",
            value: $tempGameData.recoveryInterval,
            format: .number
          )
        }
      }
      .navigationTitle("edit_timer")
      .toolbar {
        ToolbarItem(placement: .confirmationAction) {
          Button {
            gameData.name = tempGameData.name
            gameData.recoveryInterval = tempGameData.recoveryInterval
            gameData.nextRecovery.minute = min(
              gameData.nextRecovery.minute,
              tempGameData.nextRecovery.MAX_MINUTE
            )
            onSave()
            onComplete?()
          } label: { Image(systemName: "checkmark") }
            .disabled(!isNameValid() || !isRecoveryIntervalValid())
        }
        ToolbarItem(placement: .cancellationAction) {
          Button { showCancelAlert = true }
            label: { Image(systemName: "xmark") }
            .confirmationDialog(
              "confirm_remove_changes",
              isPresented: $showCancelAlert,
              titleVisibility: .visible
            ) {
              Button("discard_all_changes", role: .destructive) {
                onCancel()
                onComplete?()
              }
            }
        }
      }
    }
    .interactiveDismissDisabled()
    .presentationDetents([.large, .fraction(0.9)], selection: $currentDetent)
    .onChange(of: currentDetent) { _, newValue in
      if newValue == .fraction(0.9) {
        showCancelAlert = true
        currentDetent = .large
      }
    }
  }
}

// MARK: - Check Logic
private extension EditTabView {
  func isNameValid() -> Bool {
    !gameData.name.isEmpty
  }

  func isRecoveryIntervalValid() -> Bool {
    let recoveryInterval = gameData.recoveryInterval
    return recoveryInterval > 0 && recoveryInterval.isMultiple(of: 1)
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
