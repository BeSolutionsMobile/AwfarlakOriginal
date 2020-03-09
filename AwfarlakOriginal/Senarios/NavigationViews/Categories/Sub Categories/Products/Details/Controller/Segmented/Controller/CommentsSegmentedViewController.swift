//
//  CommentsSegmentedViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/3/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class CommentsSegmentedViewController: UIViewController ,NVActivityIndicatorViewable {
    
    //MARK: - Variables
    
    var productComments : ProductComments?
    var addComments : AddComments?
    var viewProfile : ViewProfile?
    var productDetails : ProductDetails?
    var commentsName : [String]?
    
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var contenerTableView: UIView!
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var writeeCommentTf: UITextField!{
        didSet{
            writeeCommentTf.delegate = self
            
        }
    }
    @IBOutlet weak var sendCommentBtn: UIButton!
    @IBOutlet weak var viewWriteCommentBottom: NSLayoutConstraint!
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProductComment()
    }
    
    
    
    
    
    //MARK: - Func to Get Product Comment
    
    //    func getProductComment()  {
    //        if let idProduct = ProductDetailsViewController.idProduct {
    //            self.startAnimating()
    //            Services.getComments(idProduct: idProduct, pageNumber: 1, callback: { (result) in
    //                print(result)
    //                switch result.status {
    //                case 1:
    //                    self.productComments = result
    //                    self.commentTableView.reloadData()
    //                    self.stopAnimating()
    //                case 2:
    //                    Alert.show("", massege: result.message!, context: self)
    //                    self.stopAnimating()
    //                case 3:
    //                    Alert.show("Error".localized, massege: "Comments".localized, context: self)
    //                    self.stopAnimating()
    //                default:
    //                    print(result.status)
    //                    self.stopAnimating()
    //                }
    //            }) { (error) in
    //                print(error.localizedDescription)
    //                self.stopAnimating()
    //            }
    //        }
    //    }
    //
    
    
    //MARK: - Func to Get Product Comment
    
    
    func getProductComment(){
        if let idProduct = ProductDetailsViewController.idProduct {
            self.startAnimating()
            Services.getProductDetails(idProduct: idProduct, callback: { (result) in
                print(result)
                switch result.status {
                case 1:
                    self.productDetails = result
                    if self.productDetails?.comments != nil {
                        self.commentTableView.reloadData()
                        self.stopAnimating()
                    }else {
                        Alert.show("Error".localized, massege:  "Comments".localized, context: self)
                        self.commentTableView.reloadData()
                        self.stopAnimating()
                    }
                case 2:
                    Alert.show("Error".localized, massege: result.message!, context: self)
                    self.stopAnimating()
                default:
                    print(result.status)
                    self.stopAnimating()
                }
            }) { (error) in
                print(error.localizedDescription)
                self.stopAnimating()
            }
        }
    }
    
    //MARK: - Func to Add Comments
    
    func addComment(){
        if let idProduct = ProductDetailsViewController.idProduct , let comment = writeeCommentTf.text , !comment.isEmpty {
            self.startAnimating()
            Services.addComments(comment: comment, idProduct: idProduct, idUser: UserDefault.getId(), callback: { (result) in
                print(result)
                switch result.status {
                case 1:
                    self.addComments = result
                    Alert.show("Success".localized, massege: result.message, context: self)
                    self.clearText()
                    self.getProductComment()
                    self.commentTableView.reloadData()
                    self.stopAnimating()
                case 2:
                    Alert.show("Error".localized, massege: result.message, context: self)
                    self.stopAnimating()
                default:
                    print(result.status)
                    self.stopAnimating()
                }
            }) { (error) in
                print(error.localizedDescription)
                self.stopAnimating()
            }
        }
        
    }
    
    //MARK: - Func to Empty TextFaild
    
    func clearText()  {
        writeeCommentTf.text = ""
    }
    
    
    //MARK: - IBAction
    
    @IBAction func sendCommentBtnPressed(_ sender: UIButton) {
        addComment()
    }
    
    
}

//MARK: - Extension

//MARK:-UITableViewDataSource And UITableViewDelegate

extension CommentsSegmentedViewController : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  productDetails?.comments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsSegmentedTableViewCell", for: indexPath) as! CommentsSegmentedTableViewCell
        let cellIndex = indexPath.row
        cell.ownerCommentPhoto.sd_setImage(with: URL(string: productDetails?.comments?[cellIndex].userPhoto ?? ""), placeholderImage: UIImage(named: "person1"))
        cell.ownerCommentName.text = productDetails?.comments?[cellIndex].userName
        cell.commentLbl.text = productDetails?.comments?[cellIndex].comment
        return cell
        
    }
    
    
}

