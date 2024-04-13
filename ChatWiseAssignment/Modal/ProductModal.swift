//
//  ProductModal.swift
//  ChatWiseAssignment
//
//  Created by Chetan Sanwariya on 11/04/24.
//

import Foundation

struct Products : Decodable {
    var products : [ProductModal]
}

struct ProductModal : Decodable {
    var id : Int
    var title : String
    var description : String
    var images : [String]
}
