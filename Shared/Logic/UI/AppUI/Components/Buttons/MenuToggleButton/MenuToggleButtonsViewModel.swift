//
//  MenuToggleButtonsViewModel.swift
//  Typyst
//
//  Created by Sean Wolford on 10/17/21.
//

import Combine
import Foundation

class MenuToggleButtonsViewModel: ObservableObject, Loggable {

    
    init(selectedValue: AppWindowViewModel.InterfaceControlPosition = .closed,
         isExpanded: Bool = false) {
        self.selectedValue = .closed
        self.isExpanded = isExpanded
        
        closedIsSelected = selectedValue == .closed
        aboveIsSelected = selectedValue == .above
        inlineIsSelected = selectedValue == .inline
    }
    

}
