//
//  Post.swift
//  MobileTest
//
//  Created by Stephany Samaniego on 20/6/22.
//

import Foundation

struct Post : Decodable{
    let post : Posts?
}

struct Posts : Decodable {
    let id : Int!
    let userId : Int!
    let title : String?
    let body : String?
    
}

struct selectedPost : Decodable {
    var id : Int!
    var userId : Int!
    var title : String?
    var body : String?
    var user : User!
    var comments : [Comments]?
}
