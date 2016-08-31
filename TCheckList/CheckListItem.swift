//
//  CheckListItem.swift
//  TCheckList
//
//  Created by 邢 云涛 on 16/8/15.
//  Copyright © 2016年 FuryGame. All rights reserved.
//

import Foundation

class CheckListItem:NSObject,NSCoding{
    
    var text="";
    var checked=false;
    var dueDate=NSDate()
    var shouldRemind=false
    var itemID:Int
    
    func toggleChecked(){
        checked = !checked
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(text, forKey: "text")
        aCoder.encodeBool(checked, forKey: "checked")
        aCoder.encodeBool(shouldRemind, forKey: "shouldRemind")
        aCoder.encodeObject(dueDate, forKey: "dueDate")
        aCoder.encodeInteger(itemID, forKey: "itemID")
    }
    
    override  init() {
        itemID=getNextItemID()
        super.init()
    }
    
    init(text:String){
        self.text=text
        itemID=getNextItemID()
        super.init()
        
    }
    
    required init(coder aDecoder:NSCoder) {
        text=aDecoder.decodeObjectForKey("text") as!String
        checked=aDecoder.decodeBoolForKey("checked")
        itemID=aDecoder.decodeIntegerForKey("itemID")
        shouldRemind=aDecoder.decodeBoolForKey("shouldRemind")
        dueDate=aDecoder.decodeObjectForKey("dueDate") as! NSDate
        super.init()
    }
}