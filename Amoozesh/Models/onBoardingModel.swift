//
//  onBoardingModel.swift
//  Amoozesh
//
//  Created by Apple on 03/11/2024.
//

import Foundation

struct onBoardingModel : Codable{
    var image:String
    var name:String
    var persianName:String
}


class onBoardingData {
    static let onBoardingScreens = [
        onBoardingModel(image: "one", name: "Vocabulary", persianName: "لغات"),
        onBoardingModel(image: "two", name: "Grammar", persianName: "دستور زبان"),
        onBoardingModel(image: "three", name: "Communication", persianName:  "مکالمه"),
        onBoardingModel(image: "four", name: "Books", persianName:  "کتاب ها")
    ]
}
