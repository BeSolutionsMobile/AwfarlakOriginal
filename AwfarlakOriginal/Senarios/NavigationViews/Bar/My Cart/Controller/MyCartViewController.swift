//
//  MyCartViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/1/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit
import MOLH
import Alamofire
import NVActivityIndicatorView
class MyCartViewController: UIViewController , NVActivityIndicatorViewable{
    
    //MARK: - Variables
    var totalPriceNumber : Double = 0
    var data = [[String]]()
    var sendOrder : SendOrder?
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var myCartTableView: UITableView!{
        didSet{
            myCartTableView.rowHeight = 230
        }
    }
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var completeOrderBtn: UIButton!
    @IBOutlet weak var callBtn: UIButton!
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showAndBacNavigation()
        SharedCoreData.loadMyCart()
        updateViewDesign()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        showAndBacNavigation()
        SharedCoreData.loadMyCart()

    }
    
    //MARK: - Func to  Update Design
    
    func updateViewDesign() {
        totalPrice.attributedText = NSAttributedString.withDualText2(text1: "rs".localized, ofSizeText1: 20, text2: "21.50", ofSizeText2: 20)
        chkDesignBtn()
        ValidateMyMyCart()
        clacTotal()
        
    }
    
    //MARK: - Func to Change Design According to the Language
    
    func chkDesignBtn()  {
        if MOLHLanguage.currentAppleLanguage() == "en"{
            completeOrderBtn.layer.cornerRadius = completeOrderBtn.frame.size.height / 2
            completeOrderBtn.clipsToBounds = true
            completeOrderBtn.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMaxXMaxYCorner  ]
            callBtn.layer.cornerRadius = callBtn.frame.size.height / 2
            callBtn.clipsToBounds = true
            callBtn.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner  ]
        }
        else if  MOLHLanguage.currentAppleLanguage() == "ar"{
            completeOrderBtn.layer.cornerRadius = completeOrderBtn.frame.size.height / 2
            completeOrderBtn.clipsToBounds = true
            completeOrderBtn.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner  ]
            callBtn.layer.cornerRadius = callBtn.frame.size.height / 2
            callBtn.clipsToBounds = true
            callBtn.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMaxXMaxYCorner  ]
            
        }
        
    }
    
    //MARK: - Func to  Validate My Cart
    
    func ValidateMyMyCart()  {
        if  SharedCoreData.myCartArray.count == 0 {
            RoundedCollection.emptyDataTable(TabelView: myCartTableView, View: self.view, MessageText: "MyCart2".localized)
        }
    }
    
    //MARK: - Func to Calc Total In My Cart
    
    func clacTotal()  {
        totalPriceNumber = 0
        for i in SharedCoreData.myCartArray {
            let price : Double = Double(i.productpriceafter!) ?? 0
            let count : Double = Double(i.productquantity!) ?? 0
            let totalOnProduct = price * count
            totalPriceNumber = totalPriceNumber + totalOnProduct
            totalPrice.text = "Rs.\(String(totalPriceNumber))"
        }
    }
    
    //MARK: - Func to  Send Order
    
    func getSendOrder()  {
        for i in SharedCoreData.myCartArray {
            data.append([i.productid!,i.productquantity!,i.productpriceafter!] )
        }
        print(data)
        self.startAnimating()
        Services.sendOrder(AllProduct: "\(data)", yourName: UserDefault.getName(), address: "aaaa", mobile: UserDefault.getPhone(), idRegion: 1, payment: 1, idUser: UserDefault.getId(),  callback: { (result) in
            print(result)
            switch result.status {
            case 1:
                self.sendOrder = result
                self.removeMyMyCart()
                self.tansferToPopup()
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
    
    //MARK: - Func to  Remove All Item In Cart
    
    func removeMyMyCart()  {
        SharedCoreData.deleteMyCart()
        SharedCoreData.myCartArray.removeAll()
        SharedCoreData.saveInAwfarlak()
        myCartTableView.reloadData()
        ValidateMyMyCart()
        showAndBacNavigation()
        
        
    }
    
    //MARK: - Func to  Transfer To Popup Order Send Suuessful
    
    func tansferToPopup()  {
        let vc = storyboard?.instantiateViewController(withIdentifier: "OrderSuccessfulViewController") as! OrderSuccessfulViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    
    
    
    
    //MARK: - IBAction
    
    @IBAction func callBtnPressed(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ContactUsViewController") as? ContactUsViewController {
            vc.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func complteOrderBtnPressed(_ sender: UIButton) {
        getSendOrder()
    }
    
    
    
}




//MARK: - Extension

//MARK:-UICollectionViewDelegate And UICollectionViewDataSource

extension MyCartViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  SharedCoreData.myCartArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCartTableViewCell", for: indexPath) as! MyCartTableViewCell
        let cellIndex = indexPath.item
        cell.productImage.sd_setImage(with: URL(string: SharedCoreData.myCartArray[cellIndex].productimage ?? ""), placeholderImage: UIImage(named: "appIcon1"))
        cell.productName.text = SharedCoreData.myCartArray[cellIndex].productname
        cell.priceNow.text = "Rs.\(SharedCoreData.myCartArray[cellIndex].productpriceafter ?? "")"
        cell.oldPriceLbl.attributedText = "Rs.\(SharedCoreData.myCartArray[cellIndex].productpricebefore ?? "")".strikeThrough()
        cell.productRate.rating = SharedCoreData.myCartArray[cellIndex].productrate
        if SharedCoreData.myCartArray[cellIndex].productfav == "0" {
            cell.favBtn.setImage(UIImage(named: "Fav1"), for: .normal)
        }else if SharedCoreData.myCartArray[cellIndex].productfav == "1" {
            cell.favBtn.setImage(UIImage(named: "Fav2"), for: .normal)
        }
        cell.productCount.text = SharedCoreData.myCartArray[cellIndex].productquantity
        cell.delegate = self
        cell.index = indexPath
        cell.quantity =  Int(SharedCoreData.myCartArray[cellIndex].productquantity!)!
        
        return cell
    }
    
    
    
    //MARK:- didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    
    
}


//MARK: -UpdateCart

extension MyCartViewController : UpdateCart {
    func update(countText: String, index: Int) {
        SharedCoreData.myCartArray[index].productquantity = countText
        SharedCoreData.saveInAwfarlak()
        clacTotal()
    }
    
    func delete(index: Int) {
        SharedCoreData.context.delete(SharedCoreData.myCartArray[index])
        SharedCoreData.myCartArray.remove(at: index)
        SharedCoreData.saveInAwfarlak()
        myCartTableView.reloadData()
        ValidateMyMyCart()
        showAndBacNavigation()
        
    }
    
    
}


