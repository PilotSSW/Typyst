//
// Created by Sean Wolford on 4/1/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation

class TypeWriterModel {
    enum ModelType: String, CaseIterable {
        case Olympia_SM3 = "Olympia_SM3"
        case Royal_Model_P = "Royal_Model_P"
        case Smith_Corona_Silent = "Smith_Corona_Silent"
        case Unknown = "Unknown"
    }

    let model: ModelType
    private(set) var name: String = ""
    private(set) var maker: String = ""
    private(set) var description: String? = ""
    private(set) var image: String? = nil
    private(set) var infoURL: URL? = nil

    private init(_ model: ModelType, name: String, maker: String, image: String? = nil, infoURL: String? = nil, description: String? = nil) {
        self.model = model
        self.name = name
        self.maker = maker
        self.description = description
        self.image = image
        self.infoURL = URL(string: infoURL ?? "")
    }

    convenience init(_ model: ModelType) {
        if let modelData = TypeWriterModel.models[model] {
            self.init(model,
                      name: (modelData["name"] ?? "") ?? "",
                      maker: (modelData["maker"] ?? "") ?? "",
                      image: modelData["image"] ?? nil,
                      infoURL: modelData["infoURL"] ?? nil,
                      description: modelData["description"] ?? nil)
        }
        else {
            self.init(.Unknown,
                      name: "",
                      maker: "",
                      image: nil,
                      infoURL: nil,
                      description: nil)
        }
    }

    static var models: [TypeWriterModel.ModelType: [String: String?]] = [
        .Olympia_SM3: [
            "name": "SM3",
            "maker": "Olympia",
            "image": "OlympiaSM3",
            "infoURL": "https://www.classictypewriter.com/olympia-sm3-sm4",
            "description": nil
//                """
//                Why Hello there
//                """
        ],
        .Royal_Model_P: [
            "name": "Model P",
            "maker": "Royal",
            "image": "RoyalModelP",
            "infoURL": "https://themechanicaltype.blogspot.com/2019/10/a-comprehensive-history-of-royal-model-p.html",
            "description":
                """
                This portable Royal Typewriter was manufactured by the Royal Typewriter Company in 1933. The portable Royal came in several variants of the “Quiet DeLuxe” including this model A. The model has the serial number A373262, dating it to 1933. The typewriter has a four row QWERTY keyboard with right and left shift keys and variable touch control.
                """
        ],
        .Smith_Corona_Silent: [
            "name": "Silent",
            "maker": "Smith-Corona",
            "image": "SmithCoronaSilent",
            "infoURL": "https://americanhistory.si.edu/collections/search/object/nmah_850000",
            "description": nil
//                """
//                Why Hello there
//                """
        ]
    ]
//
//    static var sm3 = TypeWriterModel(.Olympia_SM3,
//        name: "SM3",
//        maker: "Olympia",
//        image: "OlympiaSM3",
//        infoURL: "https://www.classictypewriter.com/olympia-sm3-sm4",
//        description:
//            """
//            Why Hello there
//            """)
//
//    static var modelP = TypeWriterModel(.Royal_Model_P,
//        name: "Model P",
//        maker: "Royal",
//        image: "RoyalModelP",
//        infoURL: "https://themechanicaltype.blogspot.com/2019/10/a-comprehensive-history-of-royal-model-p.html",
//        description:
//            """
//            This portable Royal Typewriter was manufactured by the Royal Typewriter Company in 1933. The portable Royal came in several variants of the “Quiet DeLuxe” including this model A. The model has the serial number A373262, dating it to 1933. The typewriter has a four row QWERTY keyboard with right and left shift keys and variable touch control.
//            """)
//
//    static var silent = TypeWriterModel(.Smith_Corona_Silent,
//        name: "Silent",
//        maker: "Smith-Corona",
//        image: "SmithCoronaSilent",
//        infoURL: "https://americanhistory.si.edu/collections/search/object/nmah_850000",
//        description:
//             """
//             Why Hello there
//             """)
}
