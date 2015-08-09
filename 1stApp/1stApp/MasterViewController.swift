//
//  MasterViewController.swift
//  1stApp
//
//  Created by XiJia jie on 15/8/8.
//  Copyright (c) 2015年 Jason Xi. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
//    var things = [ItemList]()
    
    var things: [ItemList] = [
        ItemList(name: "大宝", category: "润肤霜"),
        ItemList(name: "飘柔", category: "洗发水"),
        ItemList(name: "黑人", category: "牙膏")
    ]
    


    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {

//        things.insert(NSDate(), atIndex: 0)
//        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
//        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    func saveItem(sender: AnyObject){
        let alert = UIAlertController(title: nil, message: "Saved successfully", preferredStyle: .ActionSheet)
        println("saved successfully")
    }
    
    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let thing = things[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                
                
                
                controller.detailItem = thing
                println("thing\(thing.name)ccc\(thing.category)")
                controller.tdeatil = thing
                println(controller.detailItem?.name)
               
                
                
                
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
                let saveButton = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: "saveItem:")
                controller.navigationItem.rightBarButtonItem = saveButton
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return things.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

//        begin of ******************************************
        //从一个本地项目资源中读取data.Json文件
        var path: String = NSBundle.mainBundle().pathForResource("Item", ofType: "json")!
        var nsUrl = NSURL(fileURLWithPath: path)
        var nsData: NSData = NSData(contentsOfURL: nsUrl!)!
        
        //读取Json数据
        var json: AnyObject? = NSJSONSerialization.JSONObjectWithData(nsData, options: NSJSONReadingOptions.allZeros, error:nil)
        
//        //读取普通数据
//        var id: String = json?.objectForKey("item") as! String
//        println(id)
        
        //读取数组类型数据
        var array: [String] = json?.objectForKey("data") as! [String]
        
                println(array.count)
//        var array2: [ItemList] = json?.objectForKey("Items") as! [ItemList]
//        println("aaa2 , \(array2.count)")
//        var dict = ["id":"002", "name": "abc"]
//        
//        var jsonDict = NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.allZeros, error: nil)
//        
//        //直接写入文件
//                jsonDict?.writeToFile("/1stApp/Item.json2", atomically: true)
////        let newdata = usename.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
////        newdata.writeToFile(datapath, atomically: false)
//        println(array[indexPath.row])
////        println(array2[0].name)
//      end of*******************************************
        let thing = things[indexPath.row] as ItemList
        cell.textLabel?.text = thing.name
        cell.detailTextLabel?.text = thing.category
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            things.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            println("what happen?")
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    


}

