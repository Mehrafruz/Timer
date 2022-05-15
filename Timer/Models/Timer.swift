//
//  Timer.swift
//  Timer
//
//  Created by Мехрафруз on 30.08.2021.
//

import Foundation

struct TimerModel: Codable {
    let items: [Item]
    
    struct Item: Codable {
        let text: String
        let timer: Int
    }
}
