//
//  CellOperations.swift
//  Timer
//
//  Created by Mehrafruz Dadoboeva on 06.09.2021.
//

import Foundation

private class CancelOperation: Operation {

    override func main() {
        super.main()
        print(#function)
        sleep(1)
        if isCancelled {
            print("cancelled")
        } else {
            print("done")
        }
    }
}
