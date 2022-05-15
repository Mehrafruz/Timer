//
//  TimerPresenter+Timer.swift
//  Timer
//
//  Created by Мехрафруз on 15.05.2022.
//

import Foundation

extension TimerPresenter {
    
    func updateTime(with seconds: Int) -> Int {
        guard seconds>0 else {
            return 0
        }
        return seconds-1
    }
    
    func createGlogalTimer() {
        let timer = Timer(timeInterval: 1.0,
                          target: self,
                          selector: #selector(createTimers),
                          userInfo: nil,
                          repeats: true)
        RunLoop.current.add(timer, forMode: .common) // TODO: Для того чтобы когда прокручиваешь таймер не зависал
        timer.tolerance = 0.1
    }
    
    @objc
    func createTimers() {
        let dispatchGroup = DispatchGroup()
        let queue = DispatchQueue.global()
        dispatchGroup.enter()
        queue.async {
            var timers: [TimerModel.Item] = []
            for var timer in self.timers {
                timer.timer = self.updateTime(with: timer.timer)
                timers.append(timer)
            }
            self.timers = timers
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.view?.update()}
    }
}
