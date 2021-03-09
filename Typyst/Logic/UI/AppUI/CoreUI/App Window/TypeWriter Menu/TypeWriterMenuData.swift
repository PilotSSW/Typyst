//
//  TypeWriterMenuData.swift
//  Typyst
//
//  Created by Sean Wolford on 2/23/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import Foundation

class TypeWriterMenuOption {
    var model: TypeWriter.Model
    var name: String = ""
    var maker: String = ""
    var description: String = ""
    var image: String = ""
    var infoURL: URL
    var onClick: () -> Void

    init(_ model: TypeWriter.Model, name: String, maker: String, image: String, infoURL: String? = nil,
         onClick: @escaping () -> Void = {}, description: String) {
        self.model = model
        self.name = name
        self.maker = maker
        self.description = description
        self.image = image
        if let infoUrl = infoURL {
            self.infoURL = URL(string: infoUrl)!
        }
        else {
            self.infoURL = URL(string: "www.google.com")!
        }
        self.onClick = onClick
    }
}

class TypeWriterMenuOptions {
    static var sm3 = TypeWriterMenuOption(.Olympia_SM3,
        name: "SM3",
        maker: "Olympia",
        image: "OlympiaSM3",
        infoURL: "https://www.classictypewriter.com/olympia-sm3-sm4",
        onClick: ({  App.instance.ui.appMenu?.loadOlympiaSM3(nil) }),
        description: "Why Hello there")

    static var modelP = TypeWriterMenuOption(.Royal_Model_P,
        name: "Model P",
        maker: "Royal",
        image: "RoyalModelP",
        infoURL: "https://themechanicaltype.blogspot.com/2019/10/a-comprehensive-history-of-royal-model-p.html",
        onClick: ({  App.instance.ui.appMenu?.loadRoyalModelP(nil) }),
        description:
            """
            This portable Royal Typewriter was manufactured by the Royal Typewriter Company in 1933. The portable Royal came in several variants of the “Quiet DeLuxe” including this model A. The model has the serial number A373262, dating it to 1933. The typewriter has a four row QWERTY keyboard with right and left shift keys and variable touch control.
            """)

    static var silent = TypeWriterMenuOption(.Smith_Corona_Silent,
        name: "Silent",
        maker: "Smith-Corona",
        image: "SmithCoronaSilent",
        infoURL: "https://americanhistory.si.edu/collections/search/object/nmah_850000",
        onClick: ({  App.instance.ui.appMenu?.loadSmithCoronaSilent(nil)}),
        description: "Why Hello there")

    static var typeWriters: [TypeWriterMenuOption]{
        [ sm3, modelP, silent ]
    }
}
