//
//  TimePickerView.swift
//  TOS Timer
//
//  Created by sora on 2025/9/8.
//

import SwiftUI

struct TimePickerView: View {
  // MARK: - Properties
  let maxMinute: Int
  @Binding var minute: Int
  @Binding var second: Int
  @Binding var isLocked: Bool

  init(maxMinute: Int, minute: Binding<Int>, second: Binding<Int>, isLocked: Binding<Bool>) {
    self.maxMinute = maxMinute
    self._minute = minute
    self._second = second
    self._isLocked = isLocked
  }

  // MARK: - Body
  var body: some View {
    HStack {
      minutePicker
      Text(":")
      secondPicker
    }
    .animation(.easeInOut(duration: 0.2), value: minute + second)
  }
}

// MARK: - Subviews
private extension TimePickerView {
  @ViewBuilder
  var minutePicker: some View {
    Picker("", selection: $minute) {
      ForEach(0..<max(1, maxMinute), id: \.self) { i in
        Text("\(i)")
      }
    }
    .pickerStyle(.wheel)
    .labelsHidden()
    .disabled(isLocked)
  }

  @ViewBuilder
  var secondPicker: some View {
    Picker("", selection: $second) {
      ForEach(0..<60, id: \.self) { i in
        Text("\(i)")
      }
    }
    .pickerStyle(.wheel)
    .labelsHidden()
    .disabled(isLocked)
  }
}

// MARK: - Preview
#Preview {
  TimePickerView(
    maxMinute: 8,
    minute: .constant(0),
    second: .constant(0),
    isLocked: .constant(false)
  )
}
