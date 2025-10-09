//
//  GameData.swift
//  TOS Helper
//
//  Created by sora on 2025/10/5.
//

import SwiftUI

struct GameData: Identifiable, Codable {
  var id = UUID()
  var name: String
  var recoveryInterval: Int { didSet { nextRecovery.MAX_MINUTE = recoveryInterval - 1 }}
  var nextRecovery: NextRecovery = .init()
  var currentStamina: Int = 0
  var maxStamina: Int = 0
  var targetStamina: Int = 0
  var fullStaminaTime: Date? = nil
  var targetStaminaTime: Date? = nil

  // MARK: - Init
  init(_ name: String, recoveryInterval: Int) {
    self.name = name
    self.recoveryInterval = recoveryInterval

    nextRecovery.MAX_MINUTE = recoveryInterval - 1
    nextRecovery.minute = nextRecovery.MAX_MINUTE
    nextRecovery.second = 59
  }
}

extension GameData {
  struct NextRecovery: Codable {
    private var _second: Int = -1
    var minute: Int = -1
    var second: Int {
      get { _second }
      set {
        if newValue < 0 {
          minute -= 1
          _second = 59
        } else { _second = newValue }
      }
    }

    var MAX_MINUTE: Int = -1
  }
}
