//
//  ListViewController.swift
//  TCheckList
//
//  Created by 邢 云涛 on 16/8/22.
//  Copyright © 2016年 FuryGame. All rights reserved.
//

import Foundation
import UIKit

class ListViewController:UITableViewController,UITextFieldDelegate,IconPickerViewControllerDelegate{
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var iconImageView: UIImageView!
    weak var delegate:ListViewControllerDelegate?
    
    var isEdit=false
    var list:CheckList?
    var iconName="No Icon"
    
    
    func setEdit(){
        isEdit=true
        self.title="Edit";
        
    }
    
    func setAdd(){
        isEdit=false
        list=CheckList()
        self.title="Add";
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !isEdit{
            doneBarButton.enabled=false
           
            textField.becomeFirstResponder();
        }else{
            textField.text=list?.name
            doneBarButton.enabled=true
            self.iconName=(list?.iconName)!
            iconImageView.image = UIImage(named:iconName)
           
        }
         textField.becomeFirstResponder();
    }
    
    @IBAction func cancel(){
        delegate?.doCancel(self)
        // super.dismissViewControllerAnimated(true,completion:nil)
    }
    
    @IBAction func done(){
        if !isEdit{
            let newList=CheckList(name:textField.text!)
            newList.iconName=iconName
            delegate?.doAdd(self, list: newList)
        }else{
            list?.name=textField.text!
            list?.iconName=iconName
            delegate?.doEdit(self, list: list!)
        }
    }
    
    override func tableView(tableView:UITableView,willSelectRowAtIndexPath indexPath:NSIndexPath)->NSIndexPath?{
        if indexPath.section==1{
            return indexPath
        }
        return nil
    }
    
    func iconPicker(picker:IconPickerViewController,didPickIcon iconName:String){
        self.iconName=iconName
        iconImageView.image = UIImage(named:iconName)
        list?.iconName=iconName
        navigationController?.popViewControllerAnimated(true)
     
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let oldText:NSString=textField.text!;
        doneBarButton.enabled=(oldText.length>0)
        let newText:NSString=oldText.stringByReplacingCharactersInRange(range, withString:string)
        doneBarButton.enabled=(newText.length>0)
        return true;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier=="PickIcon"{
            
            let contronller=segue.destinationViewController as!IconPickerViewController
           // let contronller=navController.topViewController as!ListViewController;
            contronller.delegate=self;
            
            
          //  contronller.setAdd();
            
            
        }
    }
}