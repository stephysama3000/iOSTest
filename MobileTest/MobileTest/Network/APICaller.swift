//
//  APICaller.swift
//  MobileTest
//
//  Created by Stephany Samaniego on 20/6/22.
//

import Foundation
import Alamofire

class ApiCaller{
    
    /// Function for obtaining all the posts
    func fetchPosts(completion: @escaping ((Error?, [Posts]?) -> Void)){
        
        var endpoint = Endpoint.getAllPost.rawValue
        let request = AF.request(endpoint).responseJSON{(response) in
            switch response.result{
            case .success:
                if(response.result != nil){
                    let jsonData = response.data
                    do {
                        let data = try JSONDecoder().decode([Posts].self, from: jsonData!)
                        completion(nil, data)
                    } catch {
                        completion(error, nil)
                        print(error)
                    }
                }
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchPost(idPost: Int, completion: @escaping ((Error?, Posts?) -> Void)){
        
        var endpoint = (Endpoint.getPost.rawValue).replacingOccurrences(of: "@a", with: String(idPost))
        let request = AF.request(endpoint).responseJSON{(response) in
            switch response.result{
            case .success:
                if(response.result != nil){
                    let jsonData = response.data
                    do {
                        let data = try JSONDecoder().decode(Posts.self, from: jsonData!)
                        completion(nil, data)
                    } catch {
                        completion(error, nil)
                        print(error)
                    }
                }
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchUser(idUser: Int, completion: @escaping ((Error?, User?) -> Void)){
        
        var endpoint = (Endpoint.getUser.rawValue).replacingOccurrences(of: "@a", with: String(idUser))
        let request = AF.request(endpoint).responseJSON{(response) in
            switch response.result{
            case .success:
                if(response.result != nil){
                    let jsonData = response.data
                    do {
                        let data = try JSONDecoder().decode(User.self, from: jsonData!)
                        completion(nil, data)
                    } catch {
                        completion(error, nil)
                        print(error)
                    }
                }
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchComments(idPost: Int, completion: @escaping ((Error?, [Comments]?) -> Void)){
        
        var endpoint = (Endpoint.getComments.rawValue).replacingOccurrences(of: "@a", with: String(idPost))
        let request = AF.request(endpoint).responseJSON{(response) in
            switch response.result{
            case .success:
                if(response.result != nil){
                    let jsonData = response.data
                    do {
                        let data = try JSONDecoder().decode([Comments].self, from: jsonData!)
                        completion(nil, data)
                    } catch {
                        completion(error, nil)
                        print(error)
                    }
                }
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    /*
    /// Function for searching tv shows according to the show´s name typed by the user
    /// - Parameters:
    ///   - name: shows's name
    func fetchPostPerId(idPost: Int, completion: @escaping ((Error?, [Show]?) -> Void)){
        var endpoint = (Endpoint.searchShows.rawValue).replacingOccurrences(of: "@a", with: name)
        let request = AF.request(endpoint).responseJSON{(response) in
            switch response.result{
            case .success:
                if(response.result != nil){
                    let jsonData = response.data
                    
                    do {
                        let data = try JSONDecoder().decode([Show].self, from: jsonData!)
                        completion(nil, data)
                    } catch {
                     completion(error, nil)
                        print(error)
                    }
                }
                break
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    
    /// Function for obtaining all the seasons of one show
    /// - Parameters:
    ///   - idShow: tv show's identification
    func fetchUser(idUser: Int, completion: @escaping ((Error?, [Seasons]?) -> Void)){
        var endpoint = (Endpoint.getSeasons.rawValue).replacingOccurrences(of: "@a", with: String(idShow))
        let request = AF.request(endpoint).responseJSON{(response) in
            switch response.result{
            case .success:
                if(response.result != nil){
                    let jsonData = response.data
                    do {
                        let data = try JSONDecoder().decode([Seasons].self, from: jsonData!)
                        completion(nil, data)
                    } catch {
                        completion(error, nil)
                        print(error)
                    }
                }
                break
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    /// Function for obatining all the episodes of  a certain show
    /// - Parameters:
    ///   - idShow: tv show's identification
    func fetchComments(idPost: Int, completion: @escaping ((Error?, [Episodes]?) -> Void)){
        var endpoint = (Endpoint.getEpisodes.rawValue).replacingOccurrences(of: "@a", with: String(idShow))
        let request = AF.request(endpoint).responseJSON{(response) in
            switch response.result{
            case .success:
                if(response.result != nil){
                    let jsonData = response.data
                    do {
                        let data = try JSONDecoder().decode([Episodes].self, from: jsonData!)
                        completion(nil, data)
                    } catch {
                        completion(error, nil)
                        print(error)
                    }
                }
                break
            case .failure(let error):
                print(error)
            }
        }
    }*/
}
