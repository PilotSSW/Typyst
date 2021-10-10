//
//  Card.swift
//  Typyst
//
//  Created by Sean Wolford on 9/1/21.
//

import SwiftUI

struct Card<Content: View>: View {
    enum CardContentStyle {
        case childCard
        case noStyleChild
        case roundedCornerChild
        case scrollableChildCard
        case straightCorner
    }
    var contentStyle: CardContentStyle

    let title: String?
    let isResizable: Bool
    let onTitleClick: (() -> Void)?
    let content: Content

    @State private var maxContentHeight: CGFloat = 350

    init(title: String? = nil,
         cardContentStyle: CardContentStyle = .childCard,
         isResizable: Bool = false,
         contentIsOnChildCard: Bool = true,
         onTitleClick: (() -> Void)? = nil,
         @ViewBuilder _ content: () -> Content) {
        self.title = title
        self.contentStyle = cardContentStyle
        self.isResizable = isResizable
        self.onTitleClick = onTitleClick
        self.content = content()
    }

    var body: some View {
            VStack(spacing: 4) {
                if let title = title {
                    Text(title)
                        .frame(maxWidth: .infinity)
                        .asStyledCardHeader(withBackgroundColor: AppColor.cardHeaderBackground,
                                            maxHeight: 46,
                                            onClickAction: onTitleClick)
                }

                styledContent

                #if os(macOS)
                if (isResizable) {
                    ResizableDragger(backgroundColor: AppColor.cardHeaderBackground)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    let translationHeight = gesture.translation.height
                                    maxContentHeight += translationHeight

                                    if maxContentHeight <= 400 {
                                        maxContentHeight = 400
                                    }
                                    else if maxContentHeight >= 1400 {
                                        maxContentHeight = 1400
                                    }
                                }
                        )
                }
                #endif
            }
            .padding(.vertical, 4)
            .padding(.horizontal, 4)
            .asParentCard(withCornerRadius: contentStyle == .straightCorner ? 0.0 : 24.0)
    }

    @ViewBuilder
    var styledContent: some View {
        if (contentStyle == .childCard) {
                content
                    .asChildCard()
        }
        else if (contentStyle == .noStyleChild || contentStyle == .straightCorner) {
            content
        }
        else if (contentStyle == .roundedCornerChild) {
            content
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        }
        else if (contentStyle == .scrollableChildCard) {
            content
            .asScrollableCard()
            .frame(maxHeight: maxContentHeight)
        }
        else if (contentStyle == .straightCorner) {
            content
        }
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Card(title: "A Card!") {
                Text("Hello")
                    .frame(maxWidth: .infinity, minHeight: 120, maxHeight: 3000)
            }
            Card(title: "A Card!", onTitleClick: {}) {
                Text("Hello")
                    .frame(maxWidth: .infinity, minHeight: 120, maxHeight: 3000)
            }
            Card(title: "A Card!", isResizable: true) {
                Text("Hello")
                    .frame(maxWidth: .infinity, minHeight: 120, maxHeight: 3000)
            }
            Card(title: "A Card!", cardContentStyle: .scrollableChildCard) {
                Text("Hello")
                    .frame(maxWidth: .infinity, minHeight: 120, maxHeight: 120)
            }
        }
    }
}
