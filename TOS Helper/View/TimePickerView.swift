//
//  TimePickerView.swift
//  TOS Timer
//
//  Created by sora on 2025/9/8.
//

import SwiftUI

struct TimePickerView: View {
    @Binding var minute: Int
    @Binding var second: Int
    @Binding var isLocked: Bool
    
    init(_ minute: Binding<Int>,_ second: Binding<Int> ,_ isLocked: Binding<Bool>) {
        self._minute = minute
        self._second = second
        self._isLocked = isLocked
    }
    
    var body: some View {
        HStack{
            Picker("",selection: $minute){
                ForEach(0..<8,id: \.self){i in
                    Text("\(i)")
                }
            }
            .pickerStyle(.wheel)
            .disabled(isLocked)
            Text(":")
            Picker("",selection: $second){
                ForEach(0..<60,id: \.self){i in
                    Text("\(i)")
                }
            }
            .pickerStyle(.wheel)
            .disabled(isLocked)
        }
        .animation(.default,value: "\(minute)" + "\(second)")
    }
}

#Preview {
    TimePickerView(.constant(0), .constant(0), .constant(false))
}
