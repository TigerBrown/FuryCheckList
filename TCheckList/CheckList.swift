//
//  CheckList.swift
//  TCheckList
//
//  Created by 邢 云涛 on 16/8/19.
//  Copyright © 2016年 FuryGame. All rights reserved.
//

import Foundation

class CheckList:NSObject,NSCoding{
    
    var name="";
    var iconName="";
    
    var items:[CheckListItem]
    
    required init(coder aDecoder:NSCoder) {
        name=aDecoder.decodeObjectForKey("name") as!String
        items=aDecoder.decodeObjectForKey("items") as![CheckListItem]
        iconName=aDecoder.decodeObjectForKey("iconName")as!String
        
        super.init()
    }
    
    override init(){
        items=[CheckListItem]()
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(items, forKey: "items")
        aCoder.encodeObject(iconName,forKey:"iconName")
    }
    
    init(name:String){
        self.name=name
        items=[CheckListItem]()
        super.init()

    }
    
    func addNewItem(item:CheckListItem){
        items.append(item)
    }
    
    func addNewItem(newItemText text:String){
        addNewItem(CheckListItem(text:text))
    }
    
   
    func getItemCount()->Int{
        return items.count;
    }
    
    
    
    func getItemByIndex(itemIndex:Int)->CheckListItem{
        return items[itemIndex];
    }
    func getItemIndex(item:CheckListItem)->Int{
        if let index=items.indexOf(item){
            return index
        }
        return -1
    }
    
    func getItemTextByIndex(itemIndex:Int)->String{
        return items[itemIndex].text
    }
    
    func removeAtIndex(itemIndex:Int){
        items.removeAtIndex(itemIndex)
    }
   
}