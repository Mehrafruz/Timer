//
//  TimerPresenter.swift
//  Timer
//
//  Created by Мехрафруз on 30.08.2021.
//  
//

import Foundation

final class TimerPresenter {
	weak var view: TimerViewInput?
    weak var moduleOutput: TimerModuleOutput?

	private let router: TimerRouterInput
	private let interactor: TimerInteractorInput
    
    public var timers: [TimerModel.Item] = []
    public let creationDate = Date()

    init(router: TimerRouterInput, interactor: TimerInteractorInput) {
        self.router = router
        self.interactor = interactor
        createGlogalTimer()
    }
}

extension TimerPresenter: TimerModuleInput {
}

extension TimerPresenter: TimerViewOutput {
    var itemCounts: Int {
        timers.count
    }
    
    func display(at index: Int) -> TimerTableViewCellModel {
        if !timers.isEmpty {
            let currentTimer = timers[index]
            return TimerTableViewCellModel(title: currentTimer.text, time: currentTimer.timer)
        } else {
            loadTimers()
        }
        return TimerTableViewCellModel(title: "", time: -1)
    }
    
    func didTapRemoveButton(at index: Int) {
        self.timers.remove(at: index)
        self.view?.remove(at: index)
    }
    
    func didSelect(at index: Int) {
        
    }
    
    func loadTimers() {
        self.interactor.loadCurrentTimer(at: 0)
    }
    
}

extension TimerPresenter: TimerInteractorOutput {
    func didLoadCurrentText() {
        self.timers.remove(at: 0)
        self.view?.remove(at: 0)
        //тут отсчитываем 5 сек и удаляем
    }
    
    func didLoadCurrentTimer (at timers: TimerModel) {
        self.timers = timers.items
        if !self.timers.isEmpty{
            view?.update()
        } else {
            print ("Почему-то функция даанные уже заагружы вызвалась, когда данных нет")
        }
    }
    
    func didFail(with error: Error) {
        router.show(error)
    }
    
}
