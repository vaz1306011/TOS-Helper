//
//  TextBarView.swift
//  TOS Timer
//
//  Created by sora on 2025/9/8.
//

import RswiftResources
import SwiftUI

struct TextBarView: View {
  // MARK: - Properties
  @Binding var num: Int
  @Binding var subTitle: Date?

  private let title: String

  // MARK: - Init
  init(
    _ text: String,
    _ num: Binding<Int>,
    subText: Binding<Date?> = .constant(nil)
  ) {
    self.title = text
    self._num = num
    self._subTitle = subText
  }

  // MARK: - Body
  var body: some View {
    VStack(alignment: .center, spacing: 5) {
      Text(title)
        .font(.title3)
        .multilineTextAlignment(.center)
      textField
      Text(formattedDate($subTitle))
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

  func formattedDate(_ date: Binding<Date?>) -> String {
    guard let value = date.wrappedValue else { return "" }

    let relTimeFormatter = RelativeDateTimeFormatter()
    relTimeFormatter.dateTimeStyle = .named
    let now = Date()
    let reltfStr = relTimeFormatter.localizedString(
      for: value,
      relativeTo: now
    )

    return reltfStr
  }
}

// MARK: - Preview
#Preview {
  TextBarView(
    R.string.localizable.current_stamina(),
    .constant(100),
    subText: .constant(Date().addingTimeInterval(60*60*24))
  )
}
