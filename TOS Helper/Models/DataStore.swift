//
//  StoreData.swift
//  TOS Helper
//
//  Created by sora on 2025/10/9.
//

import Foundation

struct DataStore {
  // MARK: - Properties
  static let share: DataStore = .init()
  private let key = "gameDataList"

  func save(_ data: [GameData]) {
    if let data = try? JSONEncoder().encode(data) {
      UserDefaults.standard.set(data, forKey: key)
    }
  }

  func load() -> [GameData] {
    if let data = UserDefaults.standard.data(forKey: key),
       let decodedData = try? JSONDecoder().decode([GameData].self, from: data)
    {
      return decodedData
    }
    return []
  }
}
