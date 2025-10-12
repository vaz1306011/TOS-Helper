//
//  StaminaManager.swift
//  TOS Helper
//
//  Created by sora on 2025/10/12.
//

import SwiftUI

struct StaminaManager: Codable, Equatable {
  var recoveryInterval: Int { didSet { nextRecovery.MAX_MINUTE = recoveryInterval - 1 }}

  var currentStamina: Int = 0
  var maxStamina: Int = 0
  var targetStamina: Int = 0

  var nextRecovery: NextRecovery = .init()

  var fullStaminaTime: Date? = .init()
  var targetStaminaTime: Date? = .init()

  // MARK: - Init
  init(recoveryInterval: Int) {
    self.recoveryInterval = recoveryInterval

    nextRecovery.MAX_MINUTE = recoveryInterval - 1
    nextRecovery.minute = nextRecovery.MAX_MINUTE
    nextRecovery.second = 59
  }
}

// MARK: - NextRecovery
extension StaminaManager {
  struct NextRecovery: Codable, Equatable {
    var minute: Int = -1
    var second: Int = -1
    var MAX_MINUTE: Int = -1
  }
}

// MARK: - Timer Logic
extension StaminaManager {
  mutating func tick() {
    updateCurrentStaminaAndTimer()
  }
}

// MARK: - SetStaminaTime Logic
extension StaminaManager {
  mutating func setFullStaminaTime() {
    let time = getEstimatedRecoveryDate(toStamina: maxStamina)
    fullStaminaTime = time
  }

  mutating func setTargetStaminaTime() {
    let time = getEstimatedRecoveryDate(toStamina: targetStamina)
    targetStaminaTime = time
  }

  private func getEstimatedRecoveryDate(toStamina targetStamina: Int) -> Date {
    let now = Date()
    let diff = targetStamina - currentStamina - 1
    let nextRecoveryIneverval = 60 * nextRecovery.minute + nextRecovery.second
    let totalRecoveryIneverval = 60 * diff * recoveryInterval + nextRecoveryIneverval
    let targetTime = Calendar.current.date(
      byAdding: .second,
      value: Int(totalRecoveryIneverval),
      to: now
    )
    return targetTime!
  }
}

// MARK: -
extension StaminaManager {
  mutating func updateCurrentStaminaAndTimer() {
    let timeDiff = Int(fullStaminaTime?.timeIntervalSinceNow ?? 0)
    guard timeDiff > 0 else {
      currentStamina = maxStamina
      nextRecovery.minute = 0
      nextRecovery.second = 0
      return
    }
    let result = timeDiff.quotientAndRemainder(dividingBy: recoveryInterval * 60)
    let diffStamina = result.quotient + 1
    let remainingTime = result.remainder
    let (minute, second) = remainingTime.quotientAndRemainder(dividingBy: 60)

    currentStamina = min(maxStamina - diffStamina, maxStamina)
    nextRecovery.minute = minute
    nextRecovery.second = second
  }
}
