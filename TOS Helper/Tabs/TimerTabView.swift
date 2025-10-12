//
//  TimerTabView.swift
//  TOS Timer
//
//  Created by sora on 2025/9/17.
//

import Combine
import SwiftUI

struct TimerTabView: View {
  // MARK: - Properties
  @Binding var gameData: GameData

//  @State private var isCounting: Bool = false
  @State private var timerCancellable: AnyCancellable?
  private let timer = Timer.publish(every: 1, on: .main, in: .common)
    .autoconnect()

  @FocusState private var isFocused: Bool

  // MARK: - Init
  init(_ gameData: Binding<GameData>) {
    self._gameData = gameData
  }

  // MARK: - Body
  var body: some View {
    GeometryReader { geometry in
      VStack {
        staminaInput
          .frame(width: geometry.size.width * 0.8)

        TimePickerView(
          maxMinute: $gameData.staminaManager.recoveryInterval,
          minute: $gameData.staminaManager.nextRecovery.minute,
          second: $gameData.staminaManager.nextRecovery.second,
          isLocked: $gameData.isCounting
        )
        .frame(width: geometry.size.width * 0.5)

        counterButton
      }
      .frame(maxWidth: .infinity, alignment: .center)
    }
    .onAppear {
      handleTimer()
      gameData.staminaManager.updateCurrentStaminaAndTimer()
    }
    .onChange(of: gameData.isCounting) { _, _ in
      gameData.staminaManager.setFullStaminaTime()
      gameData.staminaManager.setTargetStaminaTime()
    }
    .onChange(of: gameData.staminaManager.currentStamina) { _, _ in
      gameData.staminaManager.setFullStaminaTime()
      gameData.staminaManager.setTargetStaminaTime()
    }
    .onChange(of: gameData.staminaManager.maxStamina) { _, _ in
      gameData.staminaManager.setFullStaminaTime()
    }
    .onChange(of: gameData.staminaManager.targetStamina) { _, _ in
      gameData.staminaManager.setTargetStaminaTime()
    }
  }
}

// MARK: - Subviews
private extension TimerTabView {
  @ViewBuilder
  var staminaInput: some View {
    HStack {
      TextBarView("current_stamina", $gameData.staminaManager.currentStamina)
        .focused($isFocused)
      TextBarView(
        "max_stamina",
        $gameData.staminaManager.maxStamina,
        subText: $gameData.staminaManager.fullStaminaTime
      )
      .focused($isFocused)
      TextBarView("target_stamina", $gameData.staminaManager.targetStamina, subText: $gameData.staminaManager.targetStaminaTime)
        .focused($isFocused)
    }
    .toolbar {
      ToolbarItemGroup(placement: .keyboard) {
        Spacer()
        Button(action: { isFocused = false },
               label: { Image(systemName: "xmark") })
      }
    }
  }

  @ViewBuilder
  var counterButton: some View {
    Button(action: {
      gameData.isCounting.toggle()
      handleTimer()
    }) {
      Text(gameData.isCounting ? "stop" : "start")
        .padding(.horizontal, 30)
        .padding(.vertical)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(50)
    }
    .padding(.top, 70)
  }
}

// MARK: - Timer logic
private extension TimerTabView {
  func handleTimer() {
    if gameData.isCounting {
      timerCancellable =
        timer.sink { _ in gameData.staminaManager.tick() }
    } else {
      timerCancellable?.cancel()
      timerCancellable = nil
    }
  }
}

// MARK: - Preview
#Preview {
  TimerTabView(.constant(GameData("Game name", recoveryInterval: 8)))
}
