//
//  OlympiaSM3Key.swift
//  TypystKeyboard
//
//  Created by Sean Wolford on 8/18/21.
//

import KeyLogic
import SwiftUI

struct SmithCoronaSilentKey: View {
    var viewModel: KeyViewModel
    
    var isLightKey: Bool {
        [.shift, .rightShift, .capsLock, .tab, .return, .keypadEnter, .delete, .forwardDelete].contains(viewModel.key)
    }

    var body: some View {
        if viewModel.key == .space {
            spaceBar
        }
        else {
            shapedKey
        }
    }
    
    @ViewBuilder
    var spaceBar: some View {
        GeometryReader { geometryReader in
            let size = geometryReader.size
            let height = size.height
            let width = size.width
            
            ZStack {
                ZStack {
                    RoundedRectangle(cornerRadius: min(height, width) / 24)
                        .fill(LinearGradient(colors: [
                            Color(.displayP3, red: 115/255, green: 105/255, blue: 65/255),
                            Color(.displayP3, red: 225/255, green: 205/255, blue: 205/255)
                        ], startPoint: .bottom, endPoint: .top))
                    
                    VStack(spacing: 0) {
                        RoundedRectangle(cornerRadius: min(height, width) / 32)
                            .fill(LinearGradient(colors: [
                                Color(.displayP3, red: 185/255, green: 170/255, blue: 120/255),
                                Color(.displayP3, red: 195/255, green: 185/255, blue: 145/255)
                            ], startPoint: .top, endPoint: .bottom))
                        
                        RoundedRectangle(cornerRadius: min(height, width) / 64)
                            .fill(LinearGradient(colors: [
                                Color(.displayP3, red: 185/255, green: 170/255, blue: 120/255),
                                Color(.displayP3, red: 195/255, green: 185/255, blue: 145/255)
                            ], startPoint: .top, endPoint: .bottom))
                            .frame(maxHeight: height * 0.05)
                            .padding(.top, -0.01 * height)
                            .padding(.horizontal, 0.0025 * width / (width / height))
                    }
                    .rotation3DEffect(.degrees(-4), axis: (x: 1, y: 0, z: 0))
                    .opacity(0.66)
                    .padding(.horizontal, 0.025 * width / (width / height))
                    .padding(.top, height * 0.02)
                    .padding(.bottom, height * 0.25)
                }
                .blur(radius: 0.005 * width / (width / height))
                
                RoundedRectangle(cornerRadius: min(height, width) / 24)
                    .stroke(Color(.displayP3, red: 160/255, green: 140/255, blue: 90/255), lineWidth: 0.0175 * width / (width / height))
                    .blur(radius: 0.0025 * width / (width / height))
            }
            .rotation3DEffect(.degrees(2), axis: (x: 1, y: 0, z: 0))
            .padding(.vertical, height * 0.075)
        }
    }
    
    @ViewBuilder
    var shapedKey: some View {
        GeometryReader { geometryReader in
            let size = geometryReader.size
            let height = size.height
            let width = size.width
            
            let bottomInset = height * 0.125
            
            ZStack() {
                ZStack() {
                    layer1(width: width, height: height)
                    layer2(width: width, height: height)
                    layer3(width: width, height: height, bottomInset: bottomInset)
                    layer4(width: width, height: height, bottomInset: bottomInset)
                    layer5(width: width, height: height, bottomInset: bottomInset)
                }
                .padding(.vertical, 0.01 * height)
                .padding(.horizontal, 0.01 * width)
                
                Text(viewModel.displayText)
                    .asStyledText(textSize: .custom(fontSize: min(height, width) / 2), textColor: Color.white)
                    .padding(.bottom, height / 6)
            }
        }
    }
    
    @ViewBuilder
    func layer1(width: CGFloat, height: CGFloat) -> some View {
        let keyColor = isLightKey
            ? Color(.displayP3, red: 185/255, green: 205/255, blue: 125/255, opacity: 0.85)
            : Color(.displayP3, red: 35/255, green: 90/255, blue: 60/255, opacity: 0.85)
    
        SmithCoronaSilentKeyShape()
            .stroke(keyColor, lineWidth: 0.01 * min(width, height))
            .padding(0.01 * min(width, height))
    }
    
    @ViewBuilder
    func layer2(width: CGFloat, height: CGFloat) -> some View {
        let gradient = isLightKey
            ? LinearGradient(gradient: Gradient(colors: [
                    Color(.displayP3, red: 185/255, green: 205/255, blue: 125/255, opacity: 0.85),
                    Color(.displayP3, red: 130/255, green: 150/255, blue: 65/255, opacity: 1.0)
                ]),
                startPoint: .top,
                endPoint: .bottom)
            : LinearGradient(gradient: Gradient(colors: [
                    Color(.displayP3, red: 40/255, green: 75/255, blue: 45/255, opacity: 0.85),
                    Color(.displayP3, red: 35/255, green: 60/255, blue: 40/255, opacity: 1.0)
                ]),
                startPoint: .top,
                endPoint: .bottom)
        SmithCoronaSilentKeyShape()
            .fill(gradient)
            .padding(0.01 * min(width, height))
    }
    
    @ViewBuilder
    func layer3(width: CGFloat, height: CGFloat, bottomInset: CGFloat) -> some View {
        let gradient = isLightKey
        ? LinearGradient(gradient: Gradient(colors: [
            Color(.displayP3, red: 185/255, green: 205/255, blue: 125/255, opacity: 0.85),
            Color(.displayP3, red: 140/255, green: 170/255, blue: 75/255, opacity: 1.0)
        ]),
                         startPoint: .top,
                         endPoint: .bottom)
        : LinearGradient(gradient: Gradient(colors: [
            Color(.displayP3, red: 35/255, green: 90/255, blue: 60/255, opacity: 0.85),
            Color(.displayP3, red: 40/255, green: 60/255, blue: 40/255, opacity: 1.0)
        ]),
                         startPoint: .top,
                         endPoint: .bottom)
        
        SmithCoronaSilentKeyShape()
            .fill(gradient)
            .padding(.horizontal, 0.02 * width / (width / height))
            .padding(.top, 0.015 * height)
            .padding(.bottom, bottomInset)
    }
    
    @ViewBuilder
    func layer4(width: CGFloat, height: CGFloat, bottomInset: CGFloat) -> some View {
        SmithCoronaSilentKeyShape()
            .fill(RadialGradient(gradient: Gradient(colors: [
                Color(.displayP3, red: 130/255, green: 150/255, blue: 120/255, opacity: 0.25),
                Color(.displayP3, red: 145/255, green: 160/255, blue: 120/255, opacity: 0.35)
            ]), center: .bottom, startRadius: 0, endRadius: width * 0.75))
            .padding(.horizontal, 0.05 * width / (width / height))
            .padding(.top, 0.04 * height)
            .padding(.bottom, bottomInset * 1.2)
            .blur(radius: 0.0075 * width, opaque: false)
    }
    
    @ViewBuilder
    func layer5(width: CGFloat, height: CGFloat, bottomInset: CGFloat) -> some View {
        SmithCoronaSilentKeyShape()
            .stroke(Color(.displayP3, red: 255/255, green: 252/255, blue: 250/255, opacity: 0.33),
                    lineWidth: 0.0055 * min(width, height))
            .padding(.horizontal, 0.022 * width / (width / height))
            .padding(.top, 0.017 * height)
            .padding(.bottom, bottomInset)
            .blur(radius: 0.0075 * width, opaque: false)
    }
}

struct SmithCoronaSilentKey_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = KeyViewModelFactory.createViewModel(keyCharacter: .a)
        viewModel.setSuggestedKeySize(CGSize(width: 1000, height: 1000))
        
        let viewModelShift = KeyViewModelFactory.createViewModel(keyCharacter: .shift)
        viewModelShift.setSuggestedKeySize(CGSize(width: 1000, height: 1000))
        
        let viewModelSpace = KeyViewModelFactory.createViewModel(keyCharacter: .space)
        viewModelSpace.setSuggestedKeySize(CGSize(width: 1000, height: 1000))

        return VStack {
            SmithCoronaSilentKey(viewModel: viewModel)
                .frame(width: viewModel.keySize.width,
                       height: viewModel.keySize.height,
                       alignment: .center)
                .padding(18)
            
            SmithCoronaSilentKey(viewModel: viewModelShift)
                .frame(width: viewModelShift.keySize.width,
                       height: viewModelShift.keySize.height,
                       alignment: .center)
                .padding(18)
            
            SmithCoronaSilentKey(viewModel: viewModelSpace)
                .frame(width: viewModelSpace.keySize.width,
                       height: viewModelSpace.keySize.height,
                       alignment: .center)
                .padding(18)
        }
        .previewLayout(.sizeThatFits)
    }
}
