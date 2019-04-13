//
//  ViewController.swift
//  表情键盘01
//
//  Created by yangyingwei on 2019/4/13.
//  Copyright © 2019 yangyingwei. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    private lazy var emoticonView:EmoticonView = EmoticonView()
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.inputView = emoticonView
        textView.becomeFirstResponder()
    }


}

