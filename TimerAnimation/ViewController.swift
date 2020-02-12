//
//  ViewController.swift
//  TimerAnimation
//
//  Created by richoh86 on 2020/02/12.
//  Copyright © 2020 richoh86. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setTimer()
    }
    
    private func setTimer() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0,
        target: self,
        selector: #selector(runTimer),
        userInfo: nil,
        repeats: true)
        timer.fire()
    }
    
    @objc func runTimer() {
        var secondsLeft = getSecondsLeft()
        secondsLeft -= 1
        timeLabel.text = secToTime(secondsLeft)
    }
    
    private func getSecondsLeft() -> Int {
        // 1. 24시간 초로 환산
        let oneDaySec = 60 * 60 * 24
        // 2. 현재 시간을 초로 환산
        // 시간
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        let now = Date()
        let hour = Int(formatter.string(from: now))!
        // 분
        formatter.dateFormat = "mm"
        let min = Int(formatter.string(from: now))!
        // 초
        formatter.dateFormat = "ss"
        let sec = Int(formatter.string(from: now))!
        // 초로 환산
        let nowSec = (hour * 60 * 60) + (min * 60) + sec
        // 3. 남은 초를 다시 시간 분 초로 환산
        return oneDaySec - nowSec
    }
    
    private func secToTime(_ seconds: Int) -> String {
        // 1.남은 시간 구하기
        // 초를 60으로 나누면 분
        let min = seconds / 60
        // 분을 60으로 나누면 시간
        let hour = min / 60
        // 2.남은 분 구하기
        // 분을 60으로 나눈 나머지 값은 분
        let minLeft = min % 60
        // 3.남은 초 구하기
        let secLeft = seconds % 60
        return "\(hour)시간 \(minLeft)분 \(secLeft)초 남았습니다."
    }
}

