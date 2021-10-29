//
//  ConfigurableTextField.swift
//  Typyst
//
//  Created by Sean Wolford on 10/21/21.
//

import Introspect
import SwiftUI

struct ConfigurableTextField: View {
    @ObservedObject var viewModel: ConfigurableTextFieldViewModel
    
    @Binding var text: String
    @State var placeholderText: String = ""
    
    init(_ placeholderText: String = "",
         text: Binding<String>,
         viewModel: ConfigurableTextFieldViewModel = ConfigurableTextFieldViewModel()) {
        self.placeholderText = placeholderText
        self._text = text
        self.viewModel = viewModel
    }
    
    var body: some View {
        TextField(placeholderText, text: $text,
                  onEditingChanged: viewModel.onEditingChange,
                  onCommit: viewModel.onCommit)
            .introspectTextField(customize: viewModel.introspectTextField)
            .introspectTextView(customize: viewModel.introspectTextView)
    }
}

struct ConfigurableTextField_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurableTextField(text: .constant("Some body of text!"))
    }
}
