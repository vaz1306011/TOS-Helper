//
//  TextBarView.swift
//  TOS Timer
//
//  Created by sora on 2025/9/8.
//

import SwiftUI

struct TextBarView: View {
    let text: String
    @Binding var num: Int?
    
    init(_ text: String,_ num: Binding<Int?>) {
        self.text = text
        self._num = num
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Text(text)
                .font(.headline)
            
            TextField("", value: $num, format: .number)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
                .padding(10)
                .border(Color.gray, width: 1)
                .onReceive(NotificationCenter.default.publisher(for: UITextField.textDidBeginEditingNotification)){ obj in
                    if let textField = obj.object as? UITextField {
                        textField.selectedTextRange = textField.textRange(
                            from: textField.beginningOfDocument,
                            to: textField.endOfDocument
                        )
                    }
                }
        }
        .padding()
    }
}

#Preview {
    @State var n:Int?=100
    TextBarView("當前體力",$n)
}
