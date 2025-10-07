//
//  TimerTab.swift
//  TOS Timer
//
//  Created by sora on 2025/9/17.
//

import Combine
import SwiftUI

struct TimerTabView: View {
  // MARK: - Properties
  @Binding var gameData: GameData

  @State private var nextRecoveryMinute: Int = 0
  @State private var nextStaminaSecond: Int = 0

  @State private var isCounting: Bool = false
  @State private var timerCancellable: AnyCancellable?
  private let timer = Timer.publish(every: 1, on: .main, in: .common)
    .autoconnect()

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
          maxMinute: $gameData.recoveryInterval,
          minute: $nextRecoveryMinute,
          second: $nextStaminaSecond,
          isLocked: $isCounting
        )
        .frame(width: geometry.size.width * 0.5)

        counterButton
      }
      .frame(maxWidth: .infinity, alignment: .center)
    }
  }
}

// MARK: - Subviews
private extension TimerTabView {
  @ViewBuilder
  var staminaInput: some View {
    HStack {
      TextBarView("current_stamina", $gameData.currentStamina)
      TextBarView("max_stamina", $gameData.maxStamina)
      TextBarView("target_stamina", $gameData.targetStamina)
    }
  }

  @ViewBuilder
  var counterButton: some View {
    Button(action: {
      isCounting.toggle()
      handleTimer()
    }) {
      Text(isCounting ? "stop" : "start")
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
    if isCounting {
      timerCancellable =
        timer
          .sink { _ in
            tick()
          }
    } else {
      timerCancellable?.cancel()
      timerCancellable = nil
    }
  }

  func tick() {
    nextStaminaSecond -= 1
    guard nextStaminaSecond < 0 else { return }
    nextRecoveryMinute -= 1
    nextStaminaSecond = 59
    guard nextRecoveryMinute < 0 else { return }
    nextRecoveryMinute = gameData.recoveryInterval - 1
    gameData.currentStamina += 1
  }
}

struct StatefulPreviewWrapper<Value, Content: View>: View {
  @State var value: Value
  var content: (Binding<Value>) -> Content

  init(_ value: Value, content: @escaping (Binding<Value>) -> Content) {
    _value = State(initialValue: value)
    self.content = content
  }

  var body: some View {
    content($value)
  }
}

// MARK: - Preview
#Preview {
  TimerTabView(.constant(GameData("Game name", recoveryInterval: 8)))
}
