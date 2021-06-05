//
//  Array.swift
//  Brainie
//
//  Created by Preet Patel on 5/06/21.
//

import Foundation

extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        }  else {
            return nil
        }
    }
}
