//
//  GameType.swift
//  TOS Helper
//
//  Created by sora on 2025/10/5.
//

import SwiftUI

struct GameData: Identifiable {
  let id = UUID()
  var name: String
  var recoveryInterval: Int
  var currentStamina: Int = 0
  var maxStamina: Int = 0
  var targetStamina: Int = 0
}
