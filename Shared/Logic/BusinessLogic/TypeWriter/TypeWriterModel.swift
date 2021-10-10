//
// Created by Sean Wolford on 4/1/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation

final class TypeWriterModel {
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
            "image": "Olympia_SM3",
            "infoURL": "https://www.classictypewriter.com/olympia-sm3-sm4",
            "description":
                """
                    The Olympia SM3 is one in a long line of the SM typewriter series; all of which are workhorses meant to turn out novels of work in typewriter world.
                
                    These machines are precise, with little play in the platen ensuring consistent and even spacing as the keyheads strike.
                
                    The spring loaded keys deliver a satisfying thunk as they are pressed and the strike of the keyhead is loud and clear, letting you confidently put words to paper without missed keystrikes.
                """
        ],
        .Royal_Model_P: [
            "name": "Model P",
            "maker": "Royal",
            "image": "Royal_Model_P",
            "infoURL": "https://themechanicaltype.blogspot.com/2019/10/a-comprehensive-history-of-royal-model-p.html",
            "description":
                """
                    Royal is perhaps one of the better known typewriter manufacturers. Founded in New York in 1904, the company has a long history and produced more than 70 models thoroughout the companies tenure.
                
                    The Royal Model P(ortable) is an iconic and elegant machine that came in an array of eye-catching colors and was first built in 1926 and first of many models of portables to eventually follow. The model in this photo is the Red Duotone; showcasing the Walnut and Mahogany grain underneath.
                """
        ],
        .Smith_Corona_Silent: [
            "name": "Silent",
            "maker": "Smith-Corona",
            "image": "Smith_Corona_Silent",
            "infoURL": "https://americanhistory.si.edu/collections/search/object/nmah_850000",
            "description":
                """
                    Founded as the Smith-Premier Typewriter Company in 1886, this manufacturer would rename several times and eventually merge with the Corona Typewriter Company in 1914.
                
                    The Silent and Silent-Super series were produced through-out the late 1940's and much of the 1950's; perhaps one of the more successful models the post world war II era.
                
                    These machines are not as silent as the name suggests, but more portable and well-suited to an office desk. The sounds of this typewriter are unique and immediately identifiable by someone whose heard many different typewriters.
                
                    Even today, these machines are excellent for writing longer bodies of work, with a relatively small learning curve to operate and a pleasant whirring of mechanical sound under use.
                """
        ]
    ]
}
