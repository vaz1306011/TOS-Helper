//
//  GameType.swift
//  TOS Helper
//
//  Created by sora on 2025/10/5.
//

import SwiftUI

struct GameTab: Identifiable {
  let id = UUID()
  var name: String
  var view: TimerTabView
}
