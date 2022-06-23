//
//  postsViewController.swift
//  MobileTest
//
//  Created by Stephany Samaniego on 20/6/22.
//

import UIKit
import CoreData


class postsViewController: UIViewController{
    
    @IBOutlet weak var tableViewPosts: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    var postModel = postsModel()
    var postModelCopy = postsModel()
    let userDefaults = UserDefaults.standard
    var favArrayCopy : [Int] = []
    var segment = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        self.showSpinner(onView: self.view)
        postModel.all()
        postModelCopy.all()
        actions()
    }
    
    
    func setNavigation(){
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 52.0/255, green: 199.0/255, blue: 89.0/255, alpha: 1.0)
        let buttonIcon = UIImage(named: "ic_reload")
        let rightBarButton = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addTapped))
        rightBarButton.image = buttonIcon
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func setSegmentControl(){
        segmentControl.layer.borderWidth = 1.0
        segmentControl.layer.cornerRadius = 5.0
        segmentControl.layer.borderColor = UIColor.systemGreen.cgColor
        segmentControl.layer.masksToBounds = true
    }
    
    @objc func addTapped(sender: AnyObject) {
        self.showSpinner(onView: self.view)
        postModel.all()
        actions()
    }
    
    @objc func shouldReload() {
        self.tableViewPosts.reloadData()
        self.removeSpinner()
    }
    
    @objc func shouldGoToVC() {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "postViewController") as! postViewController
        
        vc.descriptionText = postModel.Post.body
        vc.userNameText = postModel.UserPost.name
        vc.userEmailText = postModel.UserPost.email
        vc.userWebsiteText = postModel.UserPost.website
        vc.userPhoneText = postModel.UserPost.phone
        vc.comments = postModel.commentPost
        vc.idPost = postModel.Post.id
        vc.delegate = self
        
        
        navigationController?.pushViewController(vc, animated: true)
        self.removeSpinner()
    }
    
    func actions(){
        NotificationCenter.default.addObserver(self, selector: #selector(shouldReload),name:NSNotification.Name(rawValue: "reloadTable"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(shouldGoToVC),name:NSNotification.Name(rawValue: "reloadComments"), object: nil)
    }
    
    
    @IBAction func segmentControlClick(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            segment = 1
            segmentControl.backgroundColor = .white
            tableViewPosts.reloadData()
            
        case 1 :
            segment = 2
            segmentControl.backgroundColor = .white
            tableViewPosts.reloadData()
        default:
            break
        }
    }
    
    @IBAction func deleteAll(_ sender: UIButton) {
        postModel.infoPosts.removeAll()
        tableViewPosts.reloadData()
    }
    
}

extension postsViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(segment == 2){
            if(favArrayCopy.count == 0){
                return 1
            }else{
                return favArrayCopy.count
            }
            
        }else{
            if(postModel.infoPosts.count == 0){
                return 1
            }else{
                return postModel.infoPosts.count
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellPosts", for: indexPath) as! postsTableViewCell
        
        if(segment == 2){
            if(favArrayCopy.count == 0){
                cell.noPostLabel.isHidden = false
                cell.favIcon.isHidden = true
                cell.titlePost.isHidden = true
                cell.arrow.isHidden = true
                return cell
            }else{
                cell.noPostLabel.isHidden = true
                cell.favIcon.isHidden = false
                cell.titlePost.isHidden = false
                cell.arrow.isHidden = false
                var index = favArrayCopy[indexPath.row]
                let postTitle = postModelCopy.infoPosts[index-1].title
                cell.titlePost.text = postTitle
                return cell
            }
        }else{
            if(postModel.infoPosts.count == 0){
                cell.noPostLabel.isHidden = false
                cell.favIcon.isHidden = true
                cell.titlePost.isHidden = true
                cell.arrow.isHidden = true
                return cell
            }else{
                let postTitle = postModel.infoPosts[indexPath.row].title
                
                cell.noPostLabel.isHidden = true
                cell.favIcon.isHidden = false
                cell.titlePost.isHidden = false
                cell.arrow.isHidden = false
                if(favArrayCopy.contains(postModel.infoPosts[indexPath.row].id)){
                    cell.favIcon.isHidden = false
                }else{
                    cell.favIcon.isHidden = true
                }
                
                
                
                cell.titlePost.text = postTitle
                return cell
            }
        }
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showSpinner(onView: self.view)
        if(segment == 2){
            if(favArrayCopy.contains(postModelCopy.infoPosts[indexPath.row].id)){
                var idPost = postModelCopy.infoPosts[indexPath.row].id
                var idUser = postModelCopy.infoPosts[indexPath.row].userId
                postModelCopy.post(idPost: idPost!, idUser: idUser!)
            }
        }else{
            var idPost = postModel.infoPosts[indexPath.row].id
            var idUser = postModel.infoPosts[indexPath.row].userId
            postModel.post(idPost: idPost!, idUser: idUser!)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
}

extension postsViewController : postsDelegate{
    func removePosts(_ remove: Int) {
        var cnt = 0
        for i in postModel.infoPosts{
            if(i.id == remove){
                postModel.infoPosts.remove(at: cnt)
            }
            cnt += 1
        }
        tableViewPosts.reloadData()
    }
    
    func favPosts(_ favorite: [Int]) {
        favArrayCopy += favorite
        self.tableViewPosts.reloadData()
    }
    
}
