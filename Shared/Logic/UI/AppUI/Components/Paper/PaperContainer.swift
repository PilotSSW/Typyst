//
//  PaperContainer.swift
//  Typyst
//
//  Created by Sean Wolford on 9/6/21.
//

import SwiftUI

struct PaperContainer: View {
    var body: some View {
        ZStack(alignment: .center) {
            SheetOfPaper() { EmptyView() }
                .frame(maxWidth: .infinity)

            StackOfPaper()
                .frame(maxWidth: .infinity)
        }
    }
}

struct PaperContainer_Previews: PreviewProvider {
    static var previews: some View {
        PaperContainer()
    }
}
