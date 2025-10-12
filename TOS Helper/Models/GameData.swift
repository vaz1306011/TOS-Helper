//
//  GameData.swift
//  TOS Helper
//
//  Created by sora on 2025/10/5.
//

import SwiftUI

struct GameData: Identifiable, Codable, Equatable {
  var id = UUID()
  var name: String
  var staminaManager: StaminaManager
  var isCounting: Bool = false

  // MARK: - Init
  init(_ name: String, recoveryInterval: Int) {
    self.name = name
    self.staminaManager = .init(recoveryInterval: recoveryInterval)
  }
}
