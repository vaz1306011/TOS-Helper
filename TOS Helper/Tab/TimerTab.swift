//
//  TimerTab.swift
//  TOS Timer
//
//  Created by sora on 2025/9/17.
//

import SwiftUI

struct TimerTab: View {
    @State var currentStamina:Int? = 0
    @State var maxStamina:Int? = 0
    @State var targetStamina:Int? = 0
    @State var nextStaminaMinute:Int = 0
    @State var nextStaminaSecond:Int = 0
    
    var body: some View {
        NavigationStack{
            GeometryReader { geometry in
                VStack{
                    HStack {
                        TextBarView("當前體力", $currentStamina)
                        TextBarView("最大體力", $maxStamina)
                        TextBarView("目標體力", $targetStamina)
                    }
                    .frame(width: geometry.size.width*0.8)
                    
                    TimePickerView($nextStaminaMinute, $nextStaminaSecond)
                        .frame(width: geometry.size.width*0.5)
                    
                    Button(action:{
                        
                    } )
                    {
                        Text("開始")
                            .padding(.horizontal,30)
                            .padding(.vertical)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(50)
                    }
                    .padding(.top,70)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .navigationTitle(Text("Timer"))
        }
    }
}

#Preview {
    TimerTab()
}
