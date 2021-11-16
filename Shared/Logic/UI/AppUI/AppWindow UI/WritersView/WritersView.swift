//
//  WritersView.swift
//  Typyst
//
//  Created by Sean Wolford on 9/4/21.
//

import SwiftUI

struct WritersView: View {
    @StateObject
    var viewModel = WritersViewModel()

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            if viewModel.shouldShowWebView {
                BrowserView()
                    .cornerRadius(6, antialiased: true)
                    .padding(8)
                    .layoutPriority(1)
                    .neumorphicShadow(shadowIntensity: .mediumLight, radius: 20, x: 0, y: 12)
                    .neumorphicShadow(shadowIntensity: .medium, radius: 3, x: 0, y: 6)
            }
            
            TypeWritersView()
                .edgesIgnoringSafeArea(.all)
        }
        .frame(maxWidth: .infinity)
    }
}

struct TypeWriterView_Previews: PreviewProvider {
    static var previews: some View {
        let documentsService = DocumentsService()
        
        let someText =
            """
            This is a sentence!!
            This is another sentence!
            This is a huge fucking paragraph of text that should be split into several sentences for better grammar and punctuation, because runon sentences are hard to read and understand and often lead to points that lack clarity and flow to the readers who really want to enjoy the body of text.
            
            """
        var textBody = ""
        for _ in 1...40 {
            textBody += someText
        }
        
        let document = Document(documentName: "This is a new Document!",
                                textBody: textBody)
        
        documentsService.setCurrentDocument(document)
        
        let viewModel = WritersViewModel(documentsService: documentsService)
        
        return WritersView(viewModel: viewModel)
            .previewLayout(.fixed(width: 1800, height: 2200))
            
    }
}
