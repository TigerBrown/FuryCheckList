//
//  AllListViewController.swift
//  TCheckList
//
//  Created by 邢 云涛 on 16/8/19.
//  Copyright © 2016年 FuryGame. All rights reserved.
//

import UIKit
class AllListsViewController: UITableViewController,ListViewControllerDelegate,UINavigationControllerDelegate {
    
    var data:DataModel!
    
    required init?(coder aDecoder:NSCoder){
       // data=DataModel()
        
        super.init(coder: aDecoder)
        //print(dataFilePath());
        //testInitItems();
        //loadData()
        
    }
    
    func testInitItems(){
        //rowCount=10;
        for  i in 0...10 {
            let list : CheckList = CheckList();
            list.name="This is item \(i)"
            data.addNewList(list)
            
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section:Int) ->Int{
        return data.getListCount()
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell=cellForTableView(tableView)
        cell.textLabel!.text=data.getListNameByIndex(indexPath.row)
        cell.accessoryType = .DetailDisclosureButton
        let count=data.getUnCheckCountInListByIndex(indexPath.row)
        if count>0{
            cell.detailTextLabel!.text="\(count) Items Remain"
        }
        cell.imageView!.image = UIImage(named:  data.getListIconNameByIndex(indexPath.row));
        return cell;
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        data.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        // saveData()
    }
    
    func cellForTableView(tableView:UITableView)->UITableViewCell{
        let cellIdentifier="Cell"
        if let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) {
            return cell
        }
        else{
            return UITableViewCell(style:.Subtitle,reuseIdentifier:cellIdentifier);
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        data.indexOfSelectedCheckList = indexPath.row
        
        performSegueWithIdentifier("ShowCheckList", sender: data.getListByIndex(indexPath.row))
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier=="ShowCheckList"{
            (segue.destinationViewController as!CheckListViewController).checkList=sender as! CheckList
        }else if segue.identifier=="AddCheckList"{
            let navController=segue.destinationViewController as!UINavigationController
            let contronller=navController.topViewController as!ListViewController;
            contronller.delegate=self;
     
            
            contronller.setAdd();
            
            
        }
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        let navigationController = storyboard?.instantiateViewControllerWithIdentifier("ListViewNavagationController") as! UINavigationController
        let controller=navigationController.topViewController as! ListViewController
        controller.delegate=self
        controller.list=data.getListByIndex(indexPath.row)
        controller.setEdit()
        presentViewController(navigationController, animated: true, completion: nil)
    }
    
    func doCancel(controller:ListViewController){
        super.dismissViewControllerAnimated(true,completion:nil)

    }
    
    func doAdd(controller:ListViewController,list:CheckList){
        let newRowIndex=data.getListCount()
        data.addNewList(list)
       // saveData()
        let indexPath = NSIndexPath(forRow:newRowIndex,inSection:0)
        let indexPaths=[indexPath]
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation:.Automatic)
        super.dismissViewControllerAnimated(true,completion:nil)
    }
    func doEdit(controller:ListViewController,list:CheckList){
        
         let index=data.getListIndex(list)
        
        if index != -1 {
            if let cell=tableView.cellForRowAtIndexPath(NSIndexPath(forRow:index,inSection:0)){
                configTextForCell(cell,list:list)
            }
        }
        super.dismissViewControllerAnimated(true,completion:nil)
    }
    
    func configTextForCell(cell:UITableViewCell,list:CheckList){
        cell.textLabel!.text=list.name
        cell.imageView?.image=UIImage(named: list.iconName);
    }
    
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        if viewController==self{
              data.indexOfSelectedCheckList = -1
        }
    }
    override func viewDidAppear(animated: Bool) {
        navigationController?.delegate=self
        let index=data.indexOfSelectedCheckList
        if index != -1{
              performSegueWithIdentifier("ShowCheckList", sender: data.getListByIndex(index))
        }
    }
        
    
    
}
