//
//  ContentView.swift
//  TOS Helper
//
//  Created by sora on 2025/9/17.
//

import SwiftUI

struct ContentView: View {
  // MARK: - Properties
  @State private var tabs: [GameData] = [.init(name: "New Game", recoveryInterval: 8)]

  @State private var showAddingTab: Bool = false
  @State private var showDeleteAlert : Bool = false
  
  @State private var selection: UUID? = nil
  @State private var tempTab: GameData?
  private var currentTabTitle: String {
    if let selection,
       let tab = tabs.first(where: { $0.id == selection })
    {
      return tab.name
    }
    return "nil Title"
  }

  // MARK: - Body
  var body: some View {
    NavigationStack {
      TabView(selection: $selection) {
        ForEach($tabs) { tab in
          TimerTabView(gameData: tab)
            .tabItem {
              Image(systemName: "square.fill")
              Text(tab.name.wrappedValue)
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
            Button("add") { addTab() }
            Button("edit") { editCurrentTab() }
            Button("delete") { deleteCurrentTab() }
          } label: {
            Image(systemName: "ellipsis.circle.fill")
              .font(.title)
          }
        }
      }
      .sheet(isPresented: $showAddingTab, content: {
        AddTabView(
          onSave: { tab in
            tabs.append(tab)
            showAddingTab = false
            selection = tab.id
          }, onCancel: {
            showAddingTab = false
          }
        )
      })
      .sheet(item: $tempTab) { tab in
        if let index = tabs.firstIndex(where: { $0.id == tab.id }) {
          EditTabView(
            gameData: $tabs[index],
            onSave: { tempTab = nil },
            onCancel: { tempTab = nil }
          )
        }
      }
    }
  }
}

// MARK: - Menu Logic
private extension ContentView {
  func addTab() {
    showAddingTab = true
  }

  private func editCurrentTab() {
    guard let currentId = selection,
          let tab = tabs.first(where: { $0.id == currentId }) else { return }
    tempTab = tab
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
