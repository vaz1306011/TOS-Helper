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
  @State private var tabToEdit: GameTab?
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
        .sheet(item: $tabToEdit) { tab in
          EditTabView(tab: tab) { updatedTab in
            if let index = tabs.firstIndex(where: { $0.id == tab.id }) {
              tabs[index] = updatedTab
            }
            tabToEdit = nil
          }
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
    tabToEdit = tab
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

// MARK: - Sheet View
struct EditTabView: View {
  @State var tab: GameTab
  var onSave: (GameTab) -> Void

  var body: some View {
    NavigationStack {
      Form {
        TextField("Tab 名稱", text: $tab.name)
      }
      .navigationTitle("編輯 Tab")
      .toolbar {
        ToolbarItem(placement: .confirmationAction) {
          Button("完成") {
            onSave(tab)
          }
        }
      }
    }
  }
}

// MARK: - Preview
#Preview {
  ContentView()
}
