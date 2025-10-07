//
//  ContentView.swift
//  TOS Helper
//
//  Created by sora on 2025/9/17.
//

import SwiftUI

struct ContentView: View {
  // MARK: - Properties
  @State private var tabs: [GameData] = [.init("NewGame", recoveryInterval: 8)]

  @State private var showAddTab: Bool = false
  @State private var showEditTab: Bool = false
  @State private var showDeleteAlert: Bool = false

  @State private var selection: UUID? = nil
  @State private var editingTab: GameData?
  @State private var deletingTab: GameData?
  private var currentTab: GameData? {
    if let selection,
       let tab = tabs.first(where: { $0.id == selection })
    {
      return tab
    }
    return nil
  }

  // MARK: - Body
  var body: some View {
    NavigationStack {
      if tabs.isEmpty {
        EmptyTabView { addTab() }
      } else {
        TabView(selection: $selection) {
          ForEach($tabs) { tabData in timerTabView(tabData) }
        }
        .onAppear {
          if selection == nil {
            selection = tabs.first?.id
          }
        }
        .navigationTitle(currentTab?.name ?? "nil title")
        .toolbar { toolBarButtons }
      }
    }
    .sheet(isPresented: $showAddTab) { addTabSheet }
    .sheet(isPresented: $showEditTab) { editTabSheet }
    .overlay { deleteAlert }
  }
}

// MARK: - TimerTabView
private extension ContentView {
  @ViewBuilder
  func timerTabView(_ tabData: Binding<GameData>) -> some View {
    TimerTabView(tabData)
      .tabItem {
        Image(systemName: "square.fill")
        Text(tabData.name.wrappedValue)
      }
      .tag(tabData.id)
  }
}

// MARK: - ToolBarItem
private extension ContentView {
  @ToolbarContentBuilder
  var toolBarButtons: some ToolbarContent {
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
}

// MARK: - Sheet and Alert Logic
private extension ContentView {
  @ViewBuilder
  var addTabSheet: some View {
    AddTabView(
      onSave: { tab in
        tabs.append(tab)
        showAddTab = false
        selection = tab.id
      }, onCancel: {
        showAddTab = false
      }
    )
  }

  @ViewBuilder
  var editTabSheet: some View {
    if let index = tabs.firstIndex(where: { $0.id == currentTab?.id }) {
      EditTabView(
        gameData: $tabs[index],
        onSave: { showEditTab = false },
        onCancel: { showEditTab = false }
      )
    }
  }

  @ViewBuilder
  var deleteAlert: some View {
    EmptyView()
      .alert(
        "confirm_delete",
        isPresented: $showDeleteAlert
      ) {
        Button("delete", role: .destructive) {
          if let index = tabs.firstIndex(where: { $0.id == currentTab?.id }) {
            tabs.remove(at: index)
            guard !tabs.isEmpty else { return }
            let safeIndex = min(index + 1, tabs.count - 1)
            selection = tabs[safeIndex].id
          }
        }
        Button("cancel", role: .cancel) {}
      } message: {
        Text("confirm_delete_message \(currentTab?.name ?? "nil")")
      }
  }
}

// MARK: - Menu Logic
private extension ContentView {
  func addTab() {
    showAddTab = true
  }

  private func editCurrentTab() {
    editingTab = currentTab
    showEditTab = true
  }

  private func deleteCurrentTab() {
    deletingTab = currentTab
    showDeleteAlert = true
  }
}

// MARK: - Preview
#Preview {
  ContentView()
}
