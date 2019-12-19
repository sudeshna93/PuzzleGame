//
//  PostViewController.swift
//  PuzzleGame
//
//  Created by Consultant on 12/13/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit
import FacebookShare
import FacebookCore


class PostViewController: UIViewController {

    @IBOutlet weak var profileImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDetails()
    }
    
    @IBAction func postButtonAction(_ sender: Any) {
        makePhotoContent()
        makeLinkContent("Puzzle Game!!")
        
    }
    
    private func fetchDetails(){
        let request = GraphRequest(graphPath: "me", parameters: ["fields":"id, email, name, picture.width(480).height(480)"])
        request.start(completionHandler: { (connection, result, error) in
            if error != nil {
                print("Error",error!.localizedDescription)
            }
            else{
                print(result!)
                let field = result! as? [String:Any]
                if let imageURL = ((field!["picture"] as? [String: Any])?["data"] as? [String: Any])?["url"] as? String {
                    print(imageURL)
                    let url = URL(string: imageURL)
                    let data = NSData(contentsOf: url!)
                    let image = UIImage(data: data! as Data)
                    self.profileImg.image = image
                }
            }
        })
    }
    
    
    func postToPage(message: String) {
        //step 1: get user id
        let request = GraphRequest(graphPath: "/me", parameters: ["fields":"id, name"], httpMethod: .get)
        request.start { (connection, result, error) in
            guard let result = result else { return}
            if let json = result as? [String: String],
                let id = json["id"] {
                self.postToPageHelper(id, message: message)
            }
            else{
                print("invalid response")
            }
        }
    }
    
    // this actually posts to a Page, not a wall
    //does not work with user_id
    func postToPageHelper(_ id:String, message: String) {
        //step 2: post message
        
        let graph  = GraphRequest(graphPath: "/\(id)/feed", parameters: ["message": message], httpMethod: .post)
        graph.start { (connection, result, error) in
            if let err = error {
                print("Error: \(err)")
                return
            }
            if let result = result {
                print("Connection was successful with result: \(result)")
            }
        }
        
    }
    
    func makePhotoContent(){
        guard let im = UIImage(named: String("back2")) else {
            return
        }
        let photo = SharePhotoContent()
        let p = SharePhoto(image: im, userGenerated: true)
        photo.photos = [p]
        showShareDialog(photo)
        
    }
    
    func makeLinkContent(_ message: String){
        if let url = URL(string: message){
            let linkcontent = ShareLinkContent()
            linkcontent.contentURL = url
            //show
        
        }
    }
    
    
    @IBAction func signOutAction(_ sender: Any) {
        NotificationCenter.default.post(name: .signout, object: nil)
    }
    

}

extension PostViewController {

    func showShareDialog<Content: SharingContent>(_ content: Content, mode: ShareDialog.Mode = .automatic) {
        let dialog = ShareDialog(fromViewController: self, content: content, delegate: self )
        dialog.mode = mode
        dialog.show()
    }
}


extension PostViewController: SharingDelegate {

    func sharer(_ sharer: Sharing, didCompleteWithResults results: [String : Any]) {
        print("success \(results)")
    }

    func sharer(_ sharer: Sharing, didFailWithError error: Error) {
        print("error \(error)")
        if let err = error as? NSError {
            print(err.userInfo)
        }
    }

    func sharerDidCancel(_ sharer: Sharing) {
        print("failed")
    }

}

