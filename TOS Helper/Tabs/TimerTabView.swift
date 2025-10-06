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
  @State private var currentStamina: Int = 0
  @State private var maxStamina: Int = 0
  @State private var targetStamina: Int = 0

  var recoveryInterval: Int = 8
  @State private var nextRecoveryMinute: Int = 0
  @State private var nextStaminaSecond: Int = 0

  @State private var isCounting: Bool = false
  @State private var timerCancellable: AnyCancellable?
  private let timer = Timer.publish(every: 1, on: .main, in: .common)
    .autoconnect()

  // MARK: - Body
  var body: some View {
    GeometryReader { geometry in
      VStack {
        staminaInput
          .frame(width: geometry.size.width * 0.8)

        TimePickerView(
          maxMinute: recoveryInterval,
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
      TextBarView("當前體力", $currentStamina)
      TextBarView("最大體力", $maxStamina)
      TextBarView("目標體力", $targetStamina)
    }
  }

  @ViewBuilder
  var counterButton: some View {
    Button(action: {
      isCounting.toggle()
      handleTimer()
    }) {
      Text(isCounting ? "停止" : "開始")
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
    nextRecoveryMinute = recoveryInterval
    currentStamina += 1
  }
}

// MARK: - Preview
#Preview {
  TimerTabView()
}
