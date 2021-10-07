//
//  SheetOfPaper.swift
//  Typyst
//
//  Created by Sean Wolford on 9/5/21.
//

import SwiftUI

struct SheetOfPaper<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme

    var content: Content?

    init() {
        self.content = nil
    }

    init(_ content: (() -> Content)? = nil) {
        self.content = content?()
    }

    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerSize: CGSize(width: 4, height: 4))
                .fill(colorScheme == .dark
                        ? Color(.displayP3, red: 55/255, green: 55/255, blue: 55/255, opacity: 1.0)
                        : Color.white)
                .padding(13)

            RoundedRectangle(cornerSize: CGSize(width: 4, height: 4))
                .strokeBorder(Color.gray.opacity(0.133))
                .padding(12)

            if let content = content {
                content
                    .padding(.horizontal, 20)
                    .padding(.vertical, 24)
            }

        }
        .aspectRatio(8.5/11, contentMode: .fit)
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

struct SheetOfPaper_Previews: PreviewProvider {
    static var previews: some View {
        SheetOfPaper() {
            Text("Hello")
        }
    }
}
