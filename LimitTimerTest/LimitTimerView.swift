//
//  ContentView.swift
//  LimitTimerTest
//
//  Created by Yong Jun Cha on 2022/01/27.
//

import SwiftUI

struct LimitTimerView: View {
    @StateObject var limitTimerModel = LimitTimerModel()
    var body: some View {
        VStack{
            timerView
            startAndStopButtonView
        }
        .onAppear {
            limitTimerModel.setTimeCounter()
        }
    }
    
    private var timerView : some View {
        Text("\(limitTimerModel.codeTimerText)")
            .font(.system(size: 30))
            .foregroundColor(Color.pink)
            .padding()
    }
    
    private var startAndStopButtonView : some View {
        //Restart
        HStack{
            Button {
                limitTimerModel.stopCodeTimer()
                limitTimerModel.setTimeCounter()
            } label: {
                Text("시작하기")
                    .foregroundColor(Color.white)
                    .frame(width: 180, height: 70)
                    .background(Color.pink)
            }
            
            // Cancel
            Button {
                limitTimerModel.stopCodeTimer()
            } label: {
                Text("취소하기")
                    .foregroundColor(Color.white)
                    .frame(width: 180, height: 70)
                    .background(Color.green)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LimitTimerView()
    }
}
