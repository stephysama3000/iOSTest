//
//  postViewController.swift
//  MobileTest
//
//  Created by Stephany Samaniego on 21/6/22.
//

import UIKit



protocol postsDelegate: class {
    func favPosts(_ favorite: [Int])
    func removePosts(_ remove: Int)
}

class postViewController: UIViewController {

    @IBOutlet weak var descriptionPost: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userPhone: UILabel!
    @IBOutlet weak var userWebsite: UILabel!
    @IBOutlet weak var tableViewComments: UITableView!
    weak var delegate: postsDelegate?
    var favPost = [FavPost]()
    var favArray : [Int] = []
    
    var onePostModel = postsModel()
    var userNameText: String?
    var userEmailText: String?
    var userPhoneText: String?
    var userWebsiteText: String?
    var descriptionText: String?
    var idPost : Int?
    var comments : [Comments] = []
    var isTapped : Bool = false
    let userDefaults = UserDefaults.standard
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if let text = descriptionText {
                    self.descriptionPost.text = text
        }
        if let text = userNameText {
                    self.userName.text = text
        }
        if let text = userEmailText {
                    self.userEmail.text = text
        }
        if let text = userPhoneText {
                    self.userPhone.text = text
        }
        if let text = userWebsiteText {
                    self.userWebsite.text = text
        }
        setNavigation(colorStar: UIColor.white, iconFav: "star")
        checkFav()
    }
    
    func checkFav(){
        if(favArray.contains(idPost!)){
            Favorite()
        }else{
            notFavorite()
        }
    }
    
    func setNavigation(colorStar : UIColor, iconFav: String){
        
        let backImage = UIImage(systemName: "chevron.left")!.withTintColor(UIColor.white).withRenderingMode(.alwaysOriginal)
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationController?.navigationBar.backItem?.title = ""
        let buttonIcon = UIImage(systemName: iconFav)?.withTintColor(colorStar).withRenderingMode(.alwaysOriginal)
        let trashIcon = UIImage(systemName: "trash")?.withTintColor(UIColor.white).withRenderingMode(.alwaysOriginal)
        
        let rightBarButton = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addTapped))
        let trashBarButton = UIBarButtonItem(title: "Trash", style: .done, target: self, action: #selector(removePost))
        rightBarButton.image = buttonIcon
        trashBarButton.image = trashIcon
        
        self.navigationItem.rightBarButtonItems = [rightBarButton,trashBarButton]
    }
    
    @objc func addTapped(sender: AnyObject) {
        if(isTapped == false){
            Favorite()
            favArray.append(idPost!)
        }else{
            notFavorite()
            let i = favArray.firstIndex(where: {$0 == idPost})
            favArray.remove(at: i!)
        }
        delegate?.favPosts(favArray)
    }
    
    @objc func removePost(sender: AnyObject) {
        delegate?.removePosts(idPost!)
        _ = navigationController?.popViewController(animated: true)
    }
    
    func Favorite(){
        setNavigation(colorStar: UIColor.yellow, iconFav: "star.fill")
        isTapped = true
    }
    
    func notFavorite(){
        setNavigation(colorStar: UIColor.white, iconFav: "star")
        isTapped = false
    }
    
}

extension postViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellComments", for: indexPath) as! postTableViewCell
        cell.commentsLabel.text = comments[indexPath.row].body
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}

