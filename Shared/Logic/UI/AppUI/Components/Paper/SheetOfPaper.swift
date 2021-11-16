//
//  SheetOfPaper.swift
//  Typyst
//
//  Created by Sean Wolford on 9/5/21.
//

import SwiftUI

struct SheetOfPaper<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme
    
    var verticalPadding: CGFloat = 0
    var horizontalPadding: CGFloat = 0

    var content: Content?

    init() {
        self.content = nil
    }

    init(verticalPadding: CGFloat = 0, horizontalPadding: CGFloat = 0,
         _ content: (() -> Content)? = nil) {
        self.content = content?()
        self.verticalPadding = verticalPadding
        self.horizontalPadding = horizontalPadding
    }

    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerSize: CGSize(width: 4, height: 4))
                .fill(colorScheme == .dark
                        ? Color(.displayP3, red: 55/255, green: 55/255, blue: 55/255, opacity: 1.0)
                        : Color.white)
                .padding(1)

            RoundedRectangle(cornerSize: CGSize(width: 4, height: 4))
                .strokeBorder(Color.gray.opacity(0.133))

            if let content = content {
                content
                    .padding(.horizontal, horizontalPadding)
                    .padding(.vertical, verticalPadding)
            }
        }
    }
}

struct SheetOfPaper_Previews: PreviewProvider {
    static var previews: some View {
        SheetOfPaper(verticalPadding: 12, horizontalPadding: 12) {
            Text("Hello")
        }
        .padding(12)
    }
}
