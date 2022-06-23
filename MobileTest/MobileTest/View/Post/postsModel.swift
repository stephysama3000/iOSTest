//
//  postsModel.swift
//  MobileTest
//
//  Created by Stephany Samaniego on 20/6/22.
//

import Foundation

class postsModel{
    
    private lazy var API = ApiCaller()
    var infoPosts : [(Posts)] = []
    
    var Post = selectedPost(id: 0, userId: 0, title: "", body: "", user: nil, comments: nil)
    var UserPost = User(id: 0, name: "", username: "", email: "", phone: "", website: "")
    var commentPost : [(Comments)] = []
    
    /// Function for obtaining all the posts
    func all(){
        let shows = API.fetchPosts{ [self] (error, post) in
            guard let post = post, post.count > 0 else{
                return
            }
            infoPosts.removeAll()
            for infoPost in post{
                infoPosts.append(infoPost)
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadTable"), object: nil)
        }
        
    }
    
    func post(idPost : Int, idUser: Int){
        let shows = API.fetchPost(idPost: idPost){ [self] (error, post) in
            guard let post = post else{
                return
            }
            Post.id = post.id
            Post.userId = post.userId
            Post.body = post.body
            Post.title = post.title
            self.user(idUser: idUser, idPost: idPost)
        }
        
    }
    
    func user(idUser : Int, idPost : Int){
        let shows = API.fetchUser(idUser: idUser){ [self] (error, user) in
            guard let user = user else{
                return
            }
            UserPost.name = user.name
            UserPost.id = user.id
            UserPost.username = user.username
            UserPost.email = user.email
            UserPost.phone = user.phone
            UserPost.website = user.website
            self.comments(idPost: idPost)
        }
        
    }
    
    func comments(idPost : Int){
        let shows = API.fetchComments(idPost: idPost){ [self] (error, comments) in
            guard let comments = comments, comments.count > 0 else{
                return
            }
            commentPost.removeAll()
            for comment in comments{
                commentPost.append(comment)
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadComments"), object: nil)
        }
        
    }
}
