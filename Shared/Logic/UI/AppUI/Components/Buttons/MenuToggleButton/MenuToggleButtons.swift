//
//  MenuToggleButtons.swift
//  Typyst
//
//  Created by Sean Wolford on 10/17/21.
//

import Combine
import SwiftUI

struct MenuToggleButtons: View {
    private var store = Set<AnyCancellable>()
    /// View Properties: Self
    @State var isExpanded: Bool = false
    @Binding var selectedValue: AppWindowViewModel.InterfaceControlPosition
    
    /// View Properties: Button's state
    @State var closedIsSelected: Bool = false
    @State var aboveIsSelected: Bool = false
    @State var inlineIsSelected: Bool = true
    
    private func setButtonBindingStates(_ selectedState: Binding<AppWindowViewModel.InterfaceControlPosition>) {
        withAnimation {
            if _selectedValue.wrappedValue != selectedState.wrappedValue {
                $selectedValue.wrappedValue = selectedState.wrappedValue
            }
            
            closedIsSelected = selectedState.wrappedValue == .closed
            aboveIsSelected = selectedState.wrappedValue == .above
            inlineIsSelected = selectedState.wrappedValue == .inline
        }
    }
    
    init(selectedValue: Binding<AppWindowViewModel.InterfaceControlPosition>,
         isExpanded: Bool = false) {
        self._selectedValue = selectedValue
        self.isExpanded = isExpanded
        
        setButtonBindingStates(selectedValue)
    }
    
    var body: some View {
        ZStack() {
            if isExpanded {
                ZStack() {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(AppColor.buttonNeutral)
                        .opacity(0.66)
                        .neumorphicShadow(shadowIntensity: .strong, radius: 6)
                    
                    HStack() {
                        MenuToggleButton(buttonValue: .closed,
                                         isSelected: $closedIsSelected)
                        .onChange(of: closedIsSelected) { isSelected in
                            if isSelected { setButtonBindingStates(.constant(.closed)) }
                        }
                    
                        MenuToggleButton(buttonValue: .above,
                                         isSelected: $aboveIsSelected)
                        .onChange(of: aboveIsSelected) { isSelected in
                            if isSelected { setButtonBindingStates(.constant(.above)) }
                        }
                    
                        MenuToggleButton(buttonValue: .inline,
                                         isSelected: $inlineIsSelected)
                        .onChange(of: inlineIsSelected) { isSelected in
                            if isSelected { setButtonBindingStates(.constant(.inline)) }
                        }
                    }
                    .padding(6)
                    .layoutPriority(1)
                }
            }
            else {
                ZStack() {
                    Circle()
                        .buttonStyle(NeumorphicButtonStyle(backgroundColor: AppColor.buttonSecondary))
                    
                    Image(systemName: "menubar.dock.rectangle")
                        .resizable()
                        .padding(18)
                }
                .frame(width: 64, height: 64, alignment: .center)
                .padding(.leading, -12)
                .padding(.bottom, -12)
            }
        }
        .opacity(isExpanded ? 1.0 : 0.25)
        .scaleEffect(isExpanded ? 1.0 : 0.5)
        .padding(6)
        .onHover(perform: { isHovering in
            isExpanded = isHovering
        })
        .animation(.interactiveSpring()
                    .speed(0.5)
                    .delay(0.03))
    }
}

struct MenuToggleButtons_Previews: PreviewProvider {
    static var previews: some View {
        MenuToggleButtons(selectedValue: .constant(.above), isExpanded: true)
        MenuToggleButtons(selectedValue: .constant(.above), isExpanded: false)
    }
}
