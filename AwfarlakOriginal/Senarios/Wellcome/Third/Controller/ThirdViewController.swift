//
//  ThirdViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/6/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet var bigView: UIView!
    @IBOutlet weak var mainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDesign()

        // Do any additional setup after loading the view.
    }
    func updateDesign(){
        mainView.layer.cornerRadius = self.bigView.bounds.height / 2
        mainView.layer.masksToBounds = true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
