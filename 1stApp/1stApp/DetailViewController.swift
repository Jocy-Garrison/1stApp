//
//  DetailViewController.swift
//  1stApp
//
//  Created by XiJia jie on 15/8/8.
//  Copyright (c) 2015年 Jason Xi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {


    @IBOutlet var nameField: UITextField!

    @IBOutlet var categoryField: UITextField!
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    var tdeatil:ItemList?

    func configureView() {
        // Update the user interface for the detail item.
//        if let detail: AnyObject = self.detailItem {
//            if let label = self.detailDescriptionLabel {
//                label.text = detail.description
//            }
        //        }
        if let detail: AnyObject = detailItem {
            if nameField != nil{
                //nameField.text = detail.name
                nameField.text = tdeatil?.name
            }
            if categoryField != nil{
                println("category\(detail.category)+name\(detail.name)")
                //categoryField.text = detail.category
                categoryField.text = tdeatil?.name
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

