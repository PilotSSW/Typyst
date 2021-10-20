//
//  StackOfPaper.swift
//  Typyst
//
//  Created by Sean Wolford on 9/5/21.
//

import SwiftUI

struct StackOfPaper: View {
    @State var numberOfSheets: Int = 8

    private var maxSheetsShown: Int {
        min(max(1, numberOfSheets), 8)
    }

    var body: some View {
        ZStack() {
            ForEach(1...maxSheetsShown, id: \.self) { sheetIndex in
                SheetOfPaper() { EmptyView() }
                    .scaleEffect(scaleEffect(currentIndex: sheetIndex))
//                    .padding(.horizontal, sheetSpacing(currentIndex: sheetIndex))
                    .offset(x: 0, y: sheetOffset(currentIndex: sheetIndex))
            }
        }
    }
    
    func scaleEffect(currentIndex: Int) -> CGFloat {
        CGFloat(100 - ((currentIndex - 1) / 2)) * CGFloat(0.01)
    }

    func sheetSpacing(currentIndex: Int) -> CGFloat {
        return currentIndex == 0
            ? 0.0
            : CGFloat(currentIndex / maxSheetsShown * 10)
    }

    func sheetOffset(currentIndex: Int) -> CGFloat {
        return currentIndex == 0
            ? 0.0
        : CGFloat(currentIndex - 1) * CGFloat(-2.0)
    }
}

struct StackOfPaper_Previews: PreviewProvider {
    static var previews: some View {
        StackOfPaper(numberOfSheets: 50)
    }
}
