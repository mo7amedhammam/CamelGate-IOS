//
//  AnimationExtenstions.swift
//  Camel Gate
//
//  Created by wecancity on 26/07/2022.
//

import Foundation

import SwiftUI

extension Animation {
    static func ripple(index: Int) -> Animation {
        Animation.spring(dampingFraction: 0.5)
            .speed((2))
            .delay(0.03 * Double(index))
    }
    static func rippleText() -> Animation {
        Animation.spring(dampingFraction: 1.0)
            .speed((1))
            .delay(0.5)
    }
}
