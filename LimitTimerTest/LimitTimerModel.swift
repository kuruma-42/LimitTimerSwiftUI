//
//  LimitTimerModel.swift
//  LimitTimerTest
//
//  Created by Yong Jun Cha on 2022/01/27.
//

import Foundation
/// Mark: - LimitTimerModel
/// Feature : Timer 설정 및 해제의 기능이 있는 모델
class LimitTimerModel : ObservableObject {
    var codeTimer : Timer?
    @Published var codeTimerText : String = ""
    
    init() {
        print("LimitTimerModel :: Init")
    }
    
    deinit {
        stopCodeTimer()
    }
    
    // Mark: - setTimeCounter
    /// Feature: 유저에게 이메일을 전송 한 후에 타이머가 설정된다.
    /// 유저에게 5분의 입력 시간을 주고 5분이 지나면 인증시간 초과 안내와 함께
    /// 유저에게 발신한 코드와 유저가 입력한 코드를 초기화 시킨다.
    func setTimeCounter(timeLimit: Int = 300) {
        // Check CodeTimer Value To Stop When User Enter Correct Code
        guard codeTimer == nil else { return }
        
        // 5min Limit Setting
        var limitSecond = timeLimit
        var min = 0
        var second = 00
        
        // Set Timer
        codeTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [unowned self] timer in
            // Substract 1 Every Second
            limitSecond -= 1
            // Case Time Left
            limitSecond > 0 ? {
                min = limitSecond / 60
                second = limitSecond % 60
                
                String(second).count == 1 ? {
                    // 초단위가 두 자리일 때
                    codeTimerText = "\(min):0\(second) 남음"
                }() : {
                    // 초단위가 한 자리일 때
                    codeTimerText = "\(min):\(second) 남음"
                }()
                
            }() : {
                // Stop Timer
                // ** Should Stop Timer Or This Function Keep Deleting TextField **
                stopCodeTimer()
                // Chage Text
                codeTimerText = "인증시간이 초과되었습니다"
                /// ** Reset Some Value Here
            }()
        }
    }
    
    /// Mark: - stopCodeTimer
    /// Feature : UI에 있는 Timer를 멈출 때 쓴다.
    /// 멈추지 않으면 View를 이동해도 계속 타이머가 동작한다.
    public func stopCodeTimer() {
        codeTimer?.invalidate()
        codeTimer = nil
    }
}
