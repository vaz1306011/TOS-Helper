//
//  ContentView.swift
//  TOS Helper
//
//  Created by sora on 2025/9/17.
//

import SwiftUI

struct ContentView: View {
  // MARK: - Properties
  @State private var tabs: [GameTab] = [
    GameTab(name: "計時器", view: TimerTabView()),
  ]
  @State private var selection: UUID? = nil
  @State private var showEditSheet: Bool = false
  @State private var currentTab: GameTab?
  var currentTabTitle: String {
    if let selectedId = selection,
       let tab = tabs.first(where: { $0.id == selectedId })
    {
      return tab.name
    }
    return "Tabs"
  }

  // MARK: - Body
  var body: some View {
    NavigationStack {
      TabView(selection: $selection) {
        ForEach(tabs) { tab in
          tab.view
            .tabItem {
              Image(systemName: "square.fill")
              Text(tab.name)
            }
            .tag(tab.id)
        }
      }
      .onAppear {
        if selection == nil {
          selection = tabs.first?.id
        }
      }
      .navigationTitle(currentTabTitle)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Menu {
            Button("新增") { addTab() }
            Button("編輯") { editCurrentTab() }
            Button("刪除") { deleteCurrentTab() }
          } label: {
            Image(systemName: "ellipsis.circle.fill")
              .font(.title)
          }
        }
      }
      .sheet(item: $currentTab) { tab in
        EditTabView(
          tab:tab,
          onSave: { tab in
            let tabIndex = tabs.firstIndex { tab in
              tab.id == self.currentTab!.id
            }
            tabs[tabIndex!] = tab
            currentTab = nil
          },
          onCancel: {
            currentTab = nil
          }
        )
      }
    }
  }
}

// MARK: - Menu Logic
private extension ContentView {
  func addTab() {
    let newTab = GameTab(
      name: "遊戲 \(tabs.count + 1)",
      view: TimerTabView()
    )
    tabs.append(newTab)
    selection = newTab.id
  }

  private func editCurrentTab() {
    guard let currentId = selection,
          let tab = tabs.first(where: { $0.id == currentId }) else { return }
    currentTab = tab
  }

  private func deleteCurrentTab() {
    guard let currentId = selection,
          let index = tabs.firstIndex(where: { $0.id == currentId }) else { return }
    tabs.remove(at: index)
    if tabs.isEmpty {
      addTab()
    }
    selection = tabs.first?.id
  }
}

// MARK: - Preview
#Preview {
  ContentView()
}
