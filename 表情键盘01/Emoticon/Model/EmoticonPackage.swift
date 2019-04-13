//
//  EmoticonPackage.swift
//  01-表情键盘
//
//  Created by male on 15/10/23.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit

// MARK: - 表情包模型
class EmoticonPackage: NSObject {

    /// 表情包所在路径
    var id: String?
    /// 表情包的名称，显示在 toolbar 中
    var group_name_cn: String?
    /// 表情数组 - 能够保证，在使用的时候，数组已经存在，可以直接追加数据
    lazy var emoticons = [Emoticon]()
    
    init(dict: [String: AnyObject]) {
        super.init()
        
        // 不会按照顺序调用字典中的 key，不能保证生成 emoticons 数组的时候 id 已经被设置
        // setValuesForKeysWithDictionary(dict)
        
        id = dict["id"] as? String
        //print("yyw001_EmoticonPackage_id:"+id!)
        group_name_cn = dict["group_name_cn"] as? String
        
        //print("yyw002===================")
        
        //print(dict["emoticons"])
        
        if let array = dict["emoticons"] as? [[String:AnyObject]]{
            for var d in array{
                if let png = d["png"] as? String , let dir = id{
                    d["png"] = dir + "/" + png as AnyObject
                    //print("yyw003===================")
                    //print(d["png"])
                    //print("yyw004===================")
                }
               // print("yyw05=================")
               // print(d["png"])
                var emoticon = Emoticon(dict:d)
               // print(emoticon.png)
                emoticons.append(emoticon)
            }
        }
 
    }
 
    override var description: String {
        let keys = ["id", "group_name_cn", "emoticons"]
        return dictionaryWithValues(forKeys: keys).description
    }
}
