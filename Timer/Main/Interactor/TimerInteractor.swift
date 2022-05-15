//
//  TimerInteractor.swift
//  Timer
//
//  Created by Мехрафруз on 30.08.2021.
//  
//

import Foundation

final class TimerInteractor {
    weak var output: TimerInteractorOutput?
    let operationQueque = OperationQueue()
    private let networkManager: NetworkManagerDescription
    
    init(networkManager: NetworkManagerDescription) {
        self.networkManager = networkManager
    }
}

extension TimerInteractor: TimerInteractorInput {
    func loadCurrentTimer(at list: Int) {
        
        networkManager.currentTimer() { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let timers):
                    self?.output?.didLoadCurrentTimer(at: timers)
                case .failure(let error):
                    self?.output?.didFail(with: error)
                }
            }
        }
    }
    
    func didLoadCurrentText() {
        let operationQueque = OperationQueue()
        operationQueque.addOperation {
            print("didLoadCurrentText")
        }
    }

}
