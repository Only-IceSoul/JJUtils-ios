//
//  extension_bitwise.swift
//  Pods
//
//  Created by Juan J LF on 6/1/21.
//

import Foundation

infix operator >>> : BitwiseShiftPrecedence

func >>> (lhs: Int64, rhs: Int64) -> Int64 {
    return Int64(bitPattern: UInt64(bitPattern: lhs) >> UInt64(rhs))
}
