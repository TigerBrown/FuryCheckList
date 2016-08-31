//
//  IconPickerViewController.swift
//  TCheckList
//
//  Created by 邢 云涛 on 16/8/24.
//  Copyright © 2016年 FuryGame. All rights reserved.
//

import UIKit

class IconPickerViewController : UITableViewController {
    
    weak var delegate:IconPickerViewControllerDelegate?
    
    let icons=["No Icon","Appointments","Birthdays","Chores","Drinks","Folder","Groceries","Inbox","Photos","Trips"]
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section:Int) ->Int{
        return icons.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell=tableView.dequeueReusableCellWithIdentifier("IconCell", forIndexPath: indexPath)
        let iconName=icons[indexPath.row]
        cell.textLabel?.text=iconName
        cell.imageView?.image=UIImage(named:iconName);
        return cell;
    }
    
    override func tableView(tableView:UITableView,willSelectRowAtIndexPath indexPath:NSIndexPath)->NSIndexPath?{
        delegate?.iconPicker(self,didPickIcon: icons[indexPath.row])
       //    super.dismissViewControllerAnimated(true,completion:nil)
        return indexPath
    }

}
