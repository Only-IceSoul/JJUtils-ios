//
//  extension_string.swift
//  testany
//
//  Created by Juan J LF on 4/27/21.
//

import UIKit

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
    
}

extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }
    func substring(with r: Range<Int>) -> Substring {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return self[startIndex..<endIndex]
    }
    
    var isNotEmpty : Bool {
        return !isEmpty
    }
}
