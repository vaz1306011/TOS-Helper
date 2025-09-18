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
    
    init(_ minute: Binding<Int>,_ second: Binding<Int> ) {
        self._minute = minute
        self._second = second
    }
    
    var body: some View {
        HStack{
            Picker("",selection: $minute){
                ForEach(0..<8,id: \.self){i in
                    Text("\(i)")
                }
            }
            .pickerStyle(.wheel)
            Text(":")
            Picker("",selection: $second){
                ForEach(0..<60,id: \.self){i in
                    Text("\(i)")
                }
            }
            .pickerStyle(.wheel)
        }
    }
}

#Preview {
    @State var minute: Int = 0
    @State var second: Int = 0
    TimePickerView($minute, $second)
}
