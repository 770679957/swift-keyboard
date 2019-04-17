//
//  ViewController.swift
//  表情键盘01
//
//  Created by yangyingwei on 2019/4/13.
//  Copyright © 2019 yangyingwei. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    /// 表情键盘视图
    private lazy var emoticonView: EmoticonView = EmoticonView { [weak self] (emoticon) -> () in
        print("ViewController:==========")
        self?.insertEmoticon(em: emoticon)
    }
    
    /// 插入表情符号
    ///
    /// - parameter em: 表情模型
    func insertEmoticon(em: Emoticon) {
        
        // 1. 空白表情
        if em.isEmpty {
            return
        }
        
        // 2. 删除按钮
        if em.isRemoved {
            textView.deleteBackward()
            return
        }
        
        // 3. emoji
        if let emoji = em.emoji {
            textView.replace(textView.selectedTextRange!, withText: emoji)
            
            return
        }
        
        // 4. 图片表情
        insertImageEmoticon(em: em)
    }
    
    /// 插入图片表情
    private func insertImageEmoticon(em: Emoticon) {
        print(em)
        
        // 1. 图片的属性文本
        let attachment = EmoticonAttachment(emoticon: em)
        
        attachment.image = UIImage(contentsOfFile: em.imagePath)
        
        // `线高`表示字体的高度
        let lineHeight = textView.font!.lineHeight
        // frame = center + bounds * transform
        // bounds(x, y) = contentOffset
        attachment.bounds = CGRect(x: 0, y: -4, width: lineHeight, height: lineHeight)
        
        // 获得图片文本
        let imageText = NSMutableAttributedString(attributedString: NSAttributedString(attachment: attachment))
        // `添加`字体 - UIKit.framework 第一个头文件
        imageText.addAttribute(NSAttributedString.Key.font, value: textView.font!, range: NSRange(location: 0, length: 1))
        
        // 2. 记录 textView attributeString －> 转换成可变文本
        let strM = NSMutableAttributedString(attributedString: textView.attributedText)
        
        // 3. 插入图片文本
        strM.replaceCharacters(in: textView.selectedRange, with: imageText)
        
        // 4. 替换属性文本
        // 1) 记录住`光标`位置
        let range = textView.selectedRange
        // 2) 替换文本
        textView.attributedText = strM
        // 3) 恢复光标
        textView.selectedRange = NSRange(location: range.location + 1, length: 0)
    }
    
    @IBOutlet weak var textView: UITextView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.inputView = emoticonView
        textView.becomeFirstResponder()
    }


}

