//
//  Favorites.swift
//  MobileTest
//
//  Created by Stephany Samaniego on 21/6/22.
//

import Foundation

class Favorites: ObservableObject {
    
    var postFav: [Int] = []

    init() {
        postFav = []
    }
    
    // returns true if our set contains this resort
    func contains(_ idPost: Int) -> Bool {
    
        for postF in postFav{
            if(postF == idPost){
                return true
            }        }
        return false
    }

    // adds the post to our set, updates all views, and saves the change
    func add(_ idPost: Int) {
        objectWillChange.send()
        postFav.append(idPost)
        save()
    }

    // removes the resort from our set, updates all views, and saves the change
    func remove(_ idPost: Int) {
        objectWillChange.send()
        let i = postFav.firstIndex(where: {$0 == idPost})
        postFav.remove(at: i!)
        save()
    }

    func save() {
        // write out our data
    }
    
    func getFav() -> [Int] {
        return postFav
    }
    
}
