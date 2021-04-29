//
//  PathElement.swift
//  testany
//
//  Created by Juan J LF on 4/27/21.
//

import UIKit

public class PathElement {
    var type = ElementType.kCGPathElementMoveToPoint
    var points = [CGPoint]();
    public init(_ type:ElementType,_ points:[CGPoint]) {
        self.type = type;
        self.points = points;
    }
}
