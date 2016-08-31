//
//  .swift
//  TCheckList
//
//  Created by 邢 云涛 on 16/8/15.
//  Copyright © 2016年 FuryGame. All rights reserved.
//

import Foundation
import UIKit

class ItemViewController : UITableViewController,UITextFieldDelegate{
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var shouldRemindSwitch: UISwitch!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet var datePickerCell: UITableViewCell!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    weak var delegate:ItemViewControllerDelegate?
    
    var isEdit=false
    var item:CheckListItem?
    var datePikerVisible=false
  
    
    var dueDate=NSDate()
         func setEdit(){
        isEdit=true
        self.title="Edit";
      
      
    }
    
    func setAdd(){
        isEdit=false
        item=CheckListItem()
         self.title="Add";
    }
    
    @IBAction func done(){
       // print(textField.text!);
        if isEdit{
          
            item!.text=textField.text!
            item!.dueDate=dueDate
            item!.shouldRemind=shouldRemindSwitch.on
            delegate?.doEdit(self,item:item!)
        }else{
            item=CheckListItem()
            item!.text=textField.text!
            item!.dueDate=dueDate
            item!.shouldRemind=shouldRemindSwitch.on
            delegate?.doAdd(self, item:item!)
        }
        
      //  super.dismissViewControllerAnimated(true,completion:nil)
    }
    
    @IBAction func cancel(){
        delegate?.doCancel(self)
       // super.dismissViewControllerAnimated(true,completion:nil)
    }
    @IBAction func dateChanged(datePicke:UIDatePicker){
        dueDate = datePicker.date
        updateDueDateLabel()
    }
    func updateDueDateLabel(){
        let formatter=NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .ShortStyle
        dueDateLabel.text=formatter.stringFromDate(dueDate)
    }
    func showDatePicker(){
        let indexPathDatePicker=NSIndexPath(forRow:2,inSection:1)
        let indexPathDateRow = NSIndexPath(forRow: 1, inSection: 1)

        if(datePikerVisible==false){
            datePikerVisible=true
            if let dateCell = tableView.cellForRowAtIndexPath(indexPathDateRow){
                dateCell.detailTextLabel?.textColor=dateCell.detailTextLabel?.tintColor
            }
            
            if isEdit && shouldRemindSwitch.on {
                datePicker.setDate(dueDate, animated: false)
            }
            
            
            tableView.insertRowsAtIndexPaths([indexPathDatePicker],withRowAnimation: .Fade)
        }else{
            datePikerVisible=false
            if let dateCell = tableView.cellForRowAtIndexPath(indexPathDateRow){
                dateCell.detailTextLabel?.textColor = UIColor(white : 0, alpha : 0.5)
            }

            
            tableView.deleteRowsAtIndexPaths([indexPathDatePicker], withRowAnimation: .Fade)
        }
    }
    
    override func tableView(tableView:UITableView,willSelectRowAtIndexPath indexPath:NSIndexPath)->NSIndexPath?{
        if indexPath.section==1 && indexPath.row==1{
            return indexPath
        }
        return nil
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        textField.resignFirstResponder()
        if indexPath.section==1 && indexPath.row==1{
            self.showDatePicker()
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section==1 && indexPath.row==2{
            return datePickerCell
        }else{
            return super.tableView(tableView, cellForRowAtIndexPath: indexPath)
        }
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section:Int) ->Int{
        if section==1 && datePikerVisible{
            return 3
        }else{
            return super.tableView(tableView, numberOfRowsInSection :section)
        }
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section==1 && indexPath.row==2{
            return 217
        }else{
            return super.tableView(tableView, heightForRowAtIndexPath :indexPath)
        }
    }
    
    override func tableView(tableView: UITableView,var indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
        if indexPath.section == 1 && indexPath.row == 2 {
        indexPath = NSIndexPath(forRow: 0, inSection: indexPath.section)
        }
        return super.tableView(tableView,indentationLevelForRowAtIndexPath: indexPath)
    }
    
  /*  override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder();
    }*/
    override func viewDidLoad() {
        super.viewDidLoad()
        if !isEdit{
            doneBarButton.enabled=false
        }else{
            textField.text=item?.text
            shouldRemindSwitch.on=item!.shouldRemind
            dueDate=item!.dueDate
            updateDueDateLabel()
        }
        textField.becomeFirstResponder();
        datePikerVisible=false
         //   showDatePicker()
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let oldText:NSString=textField.text!;
         doneBarButton.enabled=(oldText.length>0)
        let newText:NSString=oldText.stringByReplacingCharactersInRange(range, withString:string)
        doneBarButton.enabled=(newText.length>0)
        return true;
    }
   }