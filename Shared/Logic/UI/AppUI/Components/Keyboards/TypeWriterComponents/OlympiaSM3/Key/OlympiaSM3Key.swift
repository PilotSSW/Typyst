//
//  SmithCoronaSilentKey.swift
//  TypystKeyboard
//
//  Created by Sean Wolford on 7/25/21.
//

import KeyLogic
import SwiftUI

struct OlympiaSM3Key: View {
    var viewModel: KeyViewModel
    var shouldInvertKey: Bool {
        [.shift, .rightShift, .keypadEnter, .return, .delete, .forwardDelete, .settings, .nextKeyboardGlobe, .numbers, .letters, .specials].contains(viewModel.key)
    }
    
    var isWideKey: Bool {
        [.shift, .rightShift, .capsLock, .keypadEnter, .return].contains(viewModel.key)
    }

    var body: some View {
        GeometryReader { geometryReader in
            let size = geometryReader.size
            let height = size.height
            let width = size.width * (isWideKey ? 1.5 : 1.0)

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
                    .padding(.bottom, isWideKey ? 0 : height / 6)
            }
        }
    }
    
    @ViewBuilder
    func layer1(width: CGFloat, height: CGFloat) -> some View {
        OlympiaSM3KeyShape()
            .stroke(Color(.displayP3, red: 25/255, green: 22/255, blue: 20/255, opacity: 0.85),
                    lineWidth: 0.01 * min(width, height))
            .rotationEffect(shouldInvertKey ? .degrees(180) : .zero)
            .padding(0.01 * min(width, height))
    }
    
    @ViewBuilder
    func layer2(width: CGFloat, height: CGFloat) -> some View {
        OlympiaSM3KeyShape()
            .fill(LinearGradient(gradient: Gradient(colors: [
                Color(.displayP3, red: 100/255, green: 80/255, blue: 20/255, opacity: 1.0),
                Color(.displayP3, red: 20/255, green: 20/255, blue: 20/255, opacity: 1.0)
            ]),
                                 startPoint: shouldInvertKey ? .bottom : .top,
                                 endPoint: shouldInvertKey ? .top : .bottom))
            .rotationEffect(shouldInvertKey ? .degrees(180) : .zero)
            .padding(0.01 * min(width, height))
    }
    
    @ViewBuilder
    func layer3(width: CGFloat, height: CGFloat, bottomInset: CGFloat) -> some View {
        OlympiaSM3KeyShape()
            .fill(LinearGradient(gradient: Gradient(colors: [
                Color(.displayP3, red: 65/255, green: 050/255, blue: 035/255, opacity: 1.0),
                Color(.displayP3, red: 120/255, green: 100/255, blue: 80/255, opacity: 1.0)
            ]),
                                 startPoint: shouldInvertKey ? .top : .bottom,
                                 endPoint: shouldInvertKey ? .bottom : .top))
            .rotationEffect(shouldInvertKey ? .degrees(180) : .zero)
            .padding(.horizontal, 0.02 * width / (width / height))
            .padding(.top, 0.015 * height)
            .padding(.bottom, bottomInset)
    }
    
    @ViewBuilder
    func layer4(width: CGFloat, height: CGFloat, bottomInset: CGFloat) -> some View {
        OlympiaSM3KeyShape()
            .fill(RadialGradient(gradient: Gradient(colors: [
                Color(.displayP3, red: 130/255, green: 130/255, blue: 120/255, opacity: 0.25),
                Color(.displayP3, red: 80/255, green: 70/255, blue: 80/255, opacity: 0.75)
            ]), center: shouldInvertKey ? .top : .bottom, startRadius: 0, endRadius: width * 0.75))
            .rotationEffect(shouldInvertKey ? .degrees(180) : .zero)
            .padding(.horizontal, 0.05 * width / (width / height))
            .padding(.top, 0.04 * height)
            .padding(.bottom, bottomInset * 1.2)
            .blur(radius: 0.0075 * width, opaque: false)
    }
    
    @ViewBuilder
    func layer5(width: CGFloat, height: CGFloat, bottomInset: CGFloat) -> some View {
        OlympiaSM3KeyShape()
            .stroke(Color(.displayP3, red: 255/255, green: 252/255, blue: 250/255, opacity: 0.33),
                    lineWidth: 0.0055 * min(width, height))
            .rotationEffect(shouldInvertKey ? .degrees(180) : .zero)
            .padding(.horizontal, 0.022 * width / (width / height))
            .padding(.top, 0.017 * height)
            .padding(.bottom, bottomInset)
            .blur(radius: 0.0075 * width, opaque: false)
    }
}

struct OlympiaSM3Key_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = KeyViewModelFactory.createViewModel(keyCharacter: .a)
        let _ = viewModel.setSuggestedKeySize(CGSize(width: 400, height: 400))

        let viewModel2 = KeyViewModelFactory.createViewModel(keyCharacter: .space)
        let _ = viewModel2.setSuggestedKeySize(CGSize(width: 400, height: 400))
        
        let viewModel3 = KeyViewModelFactory.createViewModel(keyCharacter: .return)
        let _ = viewModel3.setSuggestedKeySize(CGSize(width: 400, height: 400))

        VStack(alignment: .leading) {
            OlympiaSM3Key(viewModel: viewModel)
                .frame(width: viewModel.keySize.width,
                       height: viewModel.keySize.height,
                       alignment: .center)

            OlympiaSM3Key(viewModel: viewModel2)
                .frame(width: viewModel2.keySize.width,
                       height: viewModel2.keySize.height,
                       alignment: .center)
            
            OlympiaSM3Key(viewModel: viewModel3)
                .frame(width: viewModel3.keySize.width,
                       height: viewModel3.keySize.height,
                       alignment: .center)
           
            ZStack {
                Color.random
                
                OlympiaSM3KeyShape()
                    .fill(Color.gray)
            }
            .frame(width: 400, height: 400)
        }
        .previewLayout(.sizeThatFits)

    }
}
