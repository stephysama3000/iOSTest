//
//  Comments.swift
//  MobileTest
//
//  Created by Stephany Samaniego on 20/6/22.
//

import Foundation

import Foundation

struct Comment : Decodable{
    let comment : Comments?
}

struct Comments : Decodable {
    let id : Int!
    let body : String?
    
}
