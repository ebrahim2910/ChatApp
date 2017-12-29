//
//  ViewController.swift
//  ChatAppUsingFireBase
//
//  Created by Admin on 12/18/17.
//  Copyright © 2017 ITI. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController  , UITableViewDelegate , UITableViewDataSource{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var userName = "ebrahim"
    
    var messageArray = [Message]()
    var  databaseRef =  DatabaseReference.init()
    @IBAction func bSend(_ sender: Any) {
        
        
        if(textInputMessage.text != nil){
            
            let  massage = ["UserName": userName , "message": textInputMessage.text! , "date" : ServerValue.timestamp() ] as [String : Any]  
            
   let fireBaseMessage =  self.databaseRef.child("messages").childByAutoId()
            
            fireBaseMessage.setValue(massage)
        }
        
        //loadData()

        
    }
    
    
    @IBOutlet weak var textInputMessage: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    userLogin()
        
        
        self.databaseRef = Database.database().reference()
    tableView.delegate = self
        tableView.dataSource = self
        loadData()
    }

   

    func userLogin() {
    
    
        Auth.auth().signInAnonymously() {  (user ,error) in
        
        let userAnonymous  = user?.isAnonymous
            if userAnonymous == true {
            
            let uid = user?.uid
                
                print("userId \(uid)")
            
            
            
            }
        
        }
    
    }
    
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
       
        
         return messageArray.count
        
        
    }
    
    
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as?  TeamsTableViewCell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MessageTableViewCell
        
       
        cell.message.text = messageArray[indexPath.row].text
        
        return cell
        
    }
    
    func loadData(){
    
        self.databaseRef.child("messages").queryOrdered(byChild: "date").observe(.value ,  with : { (snapshot)
            in
            
            self.messageArray.removeAll()
            
            
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
            
                for snap in snapshot {
                
                    if let postDict = snap.value as? [String : AnyObject]{
                        
                        self.setMessage(msgId : snap.key , msgData : postDict)
                        
                        
                    }
                
                
                
                }
            
            
            
            
            }
        
             self.tableView.reloadData()
            
        })
     

    
    }
    
    
    
    func setMessage(msgId : String , msgData : [String:AnyObject]){
    
    let userName1 = msgData["UserName"] as? String
    
   // let date = msgData["date"] as? String
        
     let message1 = msgData["message"] as? String
        
       self.messageArray.append(Message(userName: userName1!, text: message1! ))
    
    }
    
    
}

