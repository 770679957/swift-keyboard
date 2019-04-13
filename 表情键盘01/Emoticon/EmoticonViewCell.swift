//
//  EmoticonViewCell.swift
//  表情键盘01
//
//  Created by yangyingwei on 2019/4/14.
//  Copyright © 2019 yangyingwei. All rights reserved.
//

import UIKit


class EmoticonViewCell: UICollectionViewCell {
    //表情按钮
    var emoticonButton:UIButton = UIButton()
    
    var emoticon:Emoticon? {
        didSet{
            emoticonButton.setImage(UIImage(named:(emoticon!.imagePath)), for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        contentView.addSubview(emoticonButton)
        emoticonButton.backgroundColor = UIColor.white
        emoticonButton.setTitleColor(UIColor.black, for: .normal)
        
        
        //emoticonButton.frame = CGRect.insetBy(self.bounds,4,4)
        emoticonButton.frame = self.bounds.insetBy(dx: 4,dy: 4)
        
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
}
