//
//  ViewController.swift
//  TCheckList
//
//  Created by 邢 云涛 on 16/8/11.
//  Copyright © 2016年 FuryGame. All rights reserved.
//

import UIKit

class CheckListViewController: UITableViewController,ItemViewControllerDelegate {
    
    var rowCount:Int=0
   // var items:[CheckListItem]
    var checkList:CheckList!
    
    required init?(coder aDecoder:NSCoder){
        super.init(coder: aDecoder)
    }
    
    func testInitItems(){
        rowCount=10;
        for  i in 0...rowCount-1 {
            let item : CheckListItem = CheckListItem();
            checkList.items.append(item)
            item.text="This is item \(i)"
            
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title=checkList.name
       
      //  rowCount=15555
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section:Int) ->Int{
        return checkList.getItemCount()
        
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell=tableView.dequeueReusableCellWithIdentifier("CheckListItem", forIndexPath: indexPath)
        let label=cell.viewWithTag(1000) as! UILabel
        //print("\(indexPath.row)"+"\n"+"\(indexPath.section)");
        
      

        label.text=checkList.getItemTextByIndex(indexPath.row);
         configCheckMarkForCell(cell,indexPath: indexPath)
        return cell;
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let cell=tableView.cellForRowAtIndexPath(indexPath){
            checkList.getItemByIndex(indexPath.row).toggleChecked()
               ////  saveData()
            configTextForCell(cell,item: checkList.getItemByIndex(indexPath.row))
            configCheckMarkForCell(cell,indexPath: indexPath)
            tableView.deselectRowAtIndexPath(indexPath, animated: true);
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        checkList.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
       // saveData()
    }
    
    func configCheckMarkForCell(cell:UITableViewCell,indexPath:NSIndexPath){
        let label=cell.viewWithTag(1001) as! UILabel
        label.text="√"
        label.textColor=view.tintColor
        if(checkList.getItemByIndex(indexPath.row).checked ){
              label.text="√"
            return
        }
          label.text=""
        
    }
    
    func configTextForCell(cell:UITableViewCell,item:CheckListItem){
        let label=cell.viewWithTag(1000) as! UILabel
        label.text=item.text
    }
    
    @IBAction func addItem(){
        print("HEREHEREHEREHEREHEREHEREHEREHERE");
        
    }
    
    func doCancel(controller:ItemViewController){
        super.dismissViewControllerAnimated(true,completion:nil)
    }
    func doAdd(controller:ItemViewController,item:CheckListItem){
        let newRowIndex=checkList.getItemCount()
        checkList.addNewItem(item)
      //  saveData()
        let indexPath = NSIndexPath(forRow:newRowIndex,inSection:0)
        let indexPaths=[indexPath]
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation:.Automatic)
        super.dismissViewControllerAnimated(true,completion:nil)
    }
    
    func doEdit(controller:ItemViewController,item:CheckListItem){
      
     //   saveData()
        let index=checkList.getItemIndex(item)
        if(index != -1){
            if let cell=tableView.cellForRowAtIndexPath(NSIndexPath(forRow:index,inSection:0)){
                configTextForCell(cell,item:item)
            }
        }
        super.dismissViewControllerAnimated(true,completion:nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier=="AddItem"{
            let navController=segue.destinationViewController as!UINavigationController
            let contronller=navController.topViewController as!ItemViewController;
            contronller.delegate=self;
            contronller.setAdd();
        }
        if segue.identifier=="EditItem"{
            let navController=segue.destinationViewController as!UINavigationController
            let contronller=navController.topViewController as!ItemViewController;
            contronller.delegate=self;
       
            
            if let indexPath=tableView.indexPathForCell(sender as!UITableViewCell){
                contronller.item=checkList.getItemByIndex(indexPath.row)
            }
            contronller.setEdit();
        }
 
    }

    
    

}

