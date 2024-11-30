//
//  OffsetKey.swift
//  TaskManagementApp
//
//  Created by Paulo Orquillo on 28/11/2024.
//

import SwiftUI

struct OffsetKey: PreferenceKey{
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
