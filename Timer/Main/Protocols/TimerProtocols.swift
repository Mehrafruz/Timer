//
//  TimerProtocols.swift
//  Timer
//
//  Created by Мехрафруз on 30.08.2021.
//  
//

import Foundation

protocol TimerModuleInput {
	var moduleOutput: TimerModuleOutput? { get }
}

protocol TimerModuleOutput: AnyObject {
}

protocol TimerViewInput: AnyObject {
    func update()
    func remove(at index: Int)
}

protocol TimerViewOutput: AnyObject {
    var itemCounts: Int { get }
    func display(at index: Int) -> TimerTableViewCellModel
    func didTapRemoveButton(at index: Int)
    func didSelect(at index: Int)
    func loadTimers()
}

protocol TimerInteractorInput: AnyObject {
    func loadCurrentTimer(at list: Int) //пагинация пока не реализована
}

protocol TimerInteractorOutput: AnyObject {
    func didLoadCurrentTimer(at timers: TimerModel)
    func didLoadCurrentText()

    func didFail(with error: Error)
}

protocol TimerRouterInput: AnyObject {
    func show(_ error: Error)
}
