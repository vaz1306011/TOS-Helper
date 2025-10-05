//
//  TimePickerView.swift
//  TOS Timer
//
//  Created by sora on 2025/9/8.
//

import SwiftUI

struct TimePickerView: View {
  // MARK: - Properties
  @Binding var minute: Int
  @Binding var second: Int
  @Binding var isLocked: Bool

  init(_ minute: Binding<Int>, _ second: Binding<Int>, _ isLocked: Binding<Bool>) {
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
      ForEach(0..<8, id: \.self) { i in
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
  TimePickerView(.constant(0), .constant(0), .constant(false))
}
