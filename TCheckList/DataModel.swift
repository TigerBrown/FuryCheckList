//
//  DataModel.swift
//  TCheckList
//
//  Created by 邢 云涛 on 16/8/23.
//  Copyright © 2016年 FuryGame. All rights reserved.
//

import Foundation

class DataModel{
    
    var lists=[CheckList]()
    
    var indexOfSelectedCheckList:Int{
        get {
            let index = NSUserDefaults.standardUserDefaults().integerForKey("CheckListIndex");
            if index>=0 && index<self.getListCount(){
                return index
            }else{
                return -1
            }
            
            
            //return  NSUserDefaults.standardUserDefaults().integerForKey("CheckListIndex")
        }
        set {
            return  NSUserDefaults.standardUserDefaults().setInteger(newValue,forKey: "CheckListIndex")
        }
    }
    
    init(){
        loadData()
        NSUserDefaults.standardUserDefaults().registerDefaults(["CheckListIndex":-1,"CheckListItemID":0])
    }
    
    func saveData(){
        let data=NSMutableData()
        let archiver=NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(lists, forKey: "tlist")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    func loadData(){
        let path=dataFilePath()
        print("Data Path : \(path)");
        if NSFileManager.defaultManager().fileExistsAtPath(path){
            if let data = NSData(contentsOfFile:path){
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                lists=unarchiver.decodeObjectForKey("tlist") as![CheckList]
                unarchiver.finishDecoding()
            }
        }
    }
    
    func addNewList(list:CheckList){
         lists.append(list)
    }
    
    func addNewList(name:String){
        addNewList(CheckList(name:name))
    }
    
    func addNewListItem(item:CheckListItem,listIndex:Int){
        lists[listIndex].items.append(item)
    }
    func getListCount()->Int{
        return lists.count;
    }
    
    func getListNameByIndex(listIndex:Int)->String{
        return lists[listIndex].name;
    }
    
    func getListIconNameByIndex(listIndex:Int)->String{
        return lists[listIndex].iconName;
    }
    
    func getListByIndex(listIndex:Int)->CheckList{
        return lists[listIndex];
    }
    func getListIndex(list:CheckList)->Int{
        if let index=lists.indexOf(list){
            return index
        }
        return -1
    }
    func removeAtIndex(listIndex:Int){
        lists.removeAtIndex(listIndex)
    }
    
    func getUnCheckCountInListByIndex(listIndex : Int)->Int{
        let list = lists[listIndex]
        var count = 0;
        for item in list.items{
            if !item.checked{
                ++count
            }
        }
        return count
    }
    
}