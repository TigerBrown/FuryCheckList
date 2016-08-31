//
//  ItemViewControllerDelegate.swift
//  TCheckList
//
//  Created by 邢 云涛 on 16/8/17.
//  Copyright © 2016年 FuryGame. All rights reserved.
//

import Foundation


let SaveFileName = "/tlist.plist"

protocol ItemViewControllerDelegate:class{

    func doCancel(controller:ItemViewController)
    func doAdd(controller:ItemViewController,item:CheckListItem)
    func doEdit(controller:ItemViewController,item:CheckListItem)
    
}

protocol ListViewControllerDelegate:class{
    
    func doCancel(controller:ListViewController)
    func doAdd(controller:ListViewController,list:CheckList)
    func doEdit(controller:ListViewController,list:CheckList)
}

protocol IconPickerViewControllerDelegate:class{
    func iconPicker(picker:IconPickerViewController,didPickIcon iconName:String)
}


func documentsDirectory()->[String]{
    return NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask,true)
}


func dataFilePath()->String{
    return (documentsDirectory()[0] as NSString).stringByAppendingString(SaveFileName)
}

func getNextItemID()->Int{
    let userDefaults=NSUserDefaults.standardUserDefaults()
    let itemID=userDefaults.integerForKey("CheckListItemID")
    userDefaults.setInteger(itemID+1, forKey: "CheckListItemID")
    userDefaults.synchronize()
    return itemID
}
