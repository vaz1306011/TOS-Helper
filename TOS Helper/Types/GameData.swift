//
//  GameType.swift
//  TOS Helper
//
//  Created by sora on 2025/10/5.
//

import SwiftUI

struct GameData: Identifiable {
  var id = UUID()
  var name: String
  var recoveryInterval: Int
  var currentStamina: Int = 0
  var maxStamina: Int = 0
  var targetStamina: Int = 0
  struct NextRecovery {
    var minute: Int = 0
    var second: Int = 0
  }

  var nextRecovery: NextRecovery = .init()

  // MARK: - Init
  init(_ name: String, recoveryInterval: Int) {
    self.name = name
    self.recoveryInterval = recoveryInterval
    self.nextRecovery.minute = recoveryInterval - 1
    self.nextRecovery.second = 59
  }
}
