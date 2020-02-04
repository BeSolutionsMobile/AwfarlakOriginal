//
//  CommentsSegmentedViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/3/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit

class CommentsSegmentedViewController: UIViewController  {
    
    var kyHeight:CGFloat?
    
    
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var writeeCommentTf: UITextField!{
        didSet{
            writeeCommentTf.delegate = self
            
        }
    }
    @IBOutlet weak var sendCommentBtn: UIButton!
    @IBOutlet weak var viewWriteCommentBottom: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        commentTableView.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            kyHeight = keyboardHeight
            if let kH = self.kyHeight {
                self.viewWriteCommentBottom.constant = kH - 80
                print(kH)
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func tableViewTapped()  {
        writeeCommentTf.endEditing(true)
    }
    
    //TODO: Declare textFieldDidBeginEditing here:
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.5) {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(self.keyboardWillShow),
                name: UIResponder.keyboardWillShowNotification,
                object: nil
            )
        }
        
    }
    
    
    //TODO: Declare textFieldDidEndEditing here:
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.5) {
            self.viewWriteCommentBottom.constant = 0
            self.view.layoutIfNeeded()
        }
        
    }
    
    
    
    func updateViewDesign() {
    }
    
    @IBAction func sendCommentBtnPressed(_ sender: UIButton) {
    }
    
    
}


extension CommentsSegmentedViewController : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsSegmentedTableViewCell", for: indexPath) as! CommentsSegmentedTableViewCell
        
        return cell
    }
    
    
}

