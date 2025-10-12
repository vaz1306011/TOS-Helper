//
//  ContentView.swift
//  TOS Helper
//
//  Created by sora on 2025/9/17.
//

import SwiftUI

struct ContentView: View {
  // MARK: - Properties
  @State private var tabs: [GameData] = []

  @State private var showAddSheet: Bool = false
  @State private var editingTab: GameData?
  @State private var deletingTab: GameData?

  @State private var selection: UUID? = nil
  private var currentTab: GameData? {
    if let selection,
       let tab = tabs.first(where: { $0.id == selection })
    { return tab }
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
          if selection == nil { selection = tabs.first?.id }
        }
        .navigationTitle(currentTab?.name ?? "nil title")
        .toolbar { toolBarButtons }
      }
    }
    .sheet(isPresented: .constant(showAddSheet)) { addTabSheet }
    .sheet(isPresented: .constant(editingTab != nil)) { editTabSheet }
    .overlay { deleteAlert }
    .onAppear { tabs = DataStore.share.load() }
    .onChange(of: tabs) { _, newValue in DataStore.share.save(newValue) }
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
        selection = tab.id
      },
      onCancel: {},
      onComplete: { showAddSheet = false }
    )
  }

  @ViewBuilder
  var editTabSheet: some View {
    if let index = tabs.firstIndex(where: { $0.id == currentTab?.id }) {
      EditTabView(
        gameData: $tabs[index],
        onSave: {},
        onCancel: {},
        onComplete: { editingTab = nil }
      )
    }
  }

  @ViewBuilder
  var deleteAlert: some View {
    EmptyView()
      .alert(
        "confirm_delete",
        isPresented: .constant(deletingTab != nil)
      ) {
        Button("delete", role: .destructive) {
          if let index = tabs.firstIndex(where: { $0.id == currentTab?.id }) {
            tabs.remove(at: index)
            deletingTab = nil
            guard !tabs.isEmpty else { return }
            let safeIndex = min(index + 1, tabs.count - 1)
            selection = tabs[safeIndex].id
          }
        }
        Button("cancel", role: .cancel) {
          deletingTab = nil
        }
      } message: {
        Text("confirm_delete_message \(currentTab?.name ?? "nil")")
      }
  }
}

// MARK: - Menu Logic
private extension ContentView {
  private func addTab() {
    showAddSheet = true
  }

  private func editCurrentTab() {
    editingTab = currentTab
  }

  private func deleteCurrentTab() {
    deletingTab = currentTab
  }
}

// MARK: - Preview
#Preview {
  ContentView()
}
