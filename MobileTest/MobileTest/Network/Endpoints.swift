//
//  Endpoints.swift
//  MobileTest
//
//  Created by Stephany Samaniego on 20/6/22.
//

import Foundation

public enum Endpoint: String {
    case getAllPost = "https://jsonplaceholder.typicode.com/posts"
    case getPost = "https://jsonplaceholder.typicode.com/posts/@a"
    case getUser = "https://jsonplaceholder.typicode.com/users/@a"
    case getComments = "https://jsonplaceholder.typicode.com/comments?postId=@a"
}

