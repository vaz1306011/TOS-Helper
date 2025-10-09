//
//  TextBarView.swift
//  TOS Timer
//
//  Created by sora on 2025/9/8.
//

import SwiftUI

struct TextBarView: View {
  // MARK: - Properties
  @Binding var num: Int
  private let text: LocalizedStringKey

  // MARK: - Init
  init(_ text: LocalizedStringKey, _ num: Binding<Int>) {
    self.text = text
    self._num = num
  }

  // MARK: - Body
  var body: some View {
    VStack(alignment: .center, spacing: 5) {
      Text(text)
        .font(.title3)
        .multilineTextAlignment(.center)
      textField
    }
    .padding()
  }
}

// MARK: - Subviews
private extension TextBarView {
  @ViewBuilder
  var textField: some View {
    TextField("", value: $num, format: .number)
      .font(.title2)
      .keyboardType(.numberPad)
      .multilineTextAlignment(.center)
      .padding(10)
      .border(Color.gray, width: 1)
      .onReceive(
        NotificationCenter.default.publisher(
          for: UITextField.textDidBeginEditingNotification
        )
      ) { obj in
        if let textField = obj.object as? UITextField {
          textField.selectAll(nil)
        }
      }
  }
}

// MARK: - Preview
#Preview {
  TextBarView("當前體力", .constant(100))
}
