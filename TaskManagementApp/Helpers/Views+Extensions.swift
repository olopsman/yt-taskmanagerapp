//
//  Views+Extensions.swift
//  TaskManagementApp
//
//  Created by Paulo Orquillo on 26/11/2024.
//

import SwiftUI

// MARK: Custom view extensions
extension View {
  //MARK: custom spacers
    @ViewBuilder
    func hSpacing(_ alignment: Alignment) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    @ViewBuilder
    func vSpacing(_ alignment: Alignment) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
    
    //MARK: Checking if two dates are the same
    func isSameDate(_ date1: Date, _ date2: Date) -> Bool {
        return Calendar.current.isDate(date1, inSameDayAs: date2)
    }
    
}
