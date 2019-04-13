//
//  EmoticonView.swift
//  表情键盘01
//
//  Created by yangyingwei on 2019/4/13.
//  Copyright © 2019 yangyingwei. All rights reserved.
//

import UIKit
import SnapKit

/// 可重用 Cell Id
private let EmoticonViewCellId = "EmoticonViewCellId"

class EmoticonView: UIView {

    // 表情键盘集合视图
    private lazy var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: EmoticonLayout())
    //工具栏
    private lazy var toolbar = UIToolbar()
    
    // 表情包数组
    private lazy var packages = EmoticonManager.sharedManager.packages
    
    // MARK: - 监听方法
    // 单击工具栏 item
    @objc private func clickItem(item: UIBarButtonItem) {
        print("单击工具栏 item: \(item.tag)")
    }
    
    // MARK: - 构造函数
    override init(frame:CGRect){
        var rect = UIScreen.main.bounds
        rect.size.height=226 //标准键盘高度216个点
        super.init(frame:rect)
        backgroundColor = UIColor.red
        
        setupUI() //toolbar
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - 表情布局(类中类－只允许被包含的类使用)
    private class EmoticonLayout: UICollectionViewFlowLayout {
        
         override func prepare() {
            super.prepare()
            
            let col: CGFloat = 7
            let row: CGFloat = 3
            
            let w = collectionView!.bounds.width / col
            // 如果在 iPhone 4 的屏幕，只能显示两行
            let margin = CGFloat(Int((collectionView!.bounds.height - row * w) * 0.5))
            
            itemSize = CGSize(width: w, height: w)
            minimumInteritemSpacing = 0
            minimumLineSpacing = 0
            sectionInset = UIEdgeInsets(top: margin, left: 0, bottom: margin, right: 0)
            
            scrollDirection = .horizontal
            
            collectionView?.isPagingEnabled = true
            collectionView?.bounces = false
            //collectionView?.showsHorizontalScrollIndicator = false
            
            
        }
    }
    
    
   
}

private extension EmoticonView {
    
    func setupUI(){
        backgroundColor = UIColor.white
        addSubview(collectionView)
        addSubview(toolbar)
        
        // 2. 自动布局
        toolbar.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.snp_bottom)
            make.left.equalTo(self.snp_left)
            make.right.equalTo(self.snp_right)
            make.height.equalTo(44)
        }
        collectionView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp_top)
            make.bottom.equalTo(toolbar.snp_top)
            make.left.equalTo(self.snp_left)
            make.right.equalTo(self.snp_right)
        }
        
        // 3. 准备控件
        prepareToolbar()
        prepareCollectionView()
        
        
    }
    
    
    /// 准备工具栏
    private func prepareToolbar() {
        // 0. tintColor
        toolbar.tintColor = UIColor.darkGray
        var index = 0
        var items = [UIBarButtonItem]()
        for s in ["最近","默认","emoji","浪小花"]{
            items.append(UIBarButtonItem(title: s, style: .plain, target: self, action: #selector(clickItem)))
            index = index + 1
            items.last?.tag = index
            items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        }
    
        items.removeLast()
        toolbar.items = items
 
    }
    
    /// 准备 collectionView
    private func prepareCollectionView() {
        collectionView.backgroundColor = UIColor.lightGray
        
        // 注册 cell
        //collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: EmoticonViewCellId)
        collectionView.register(EmoticonViewCell.self, forCellWithReuseIdentifier: EmoticonViewCellId)
        
        // 设置数据源
        collectionView.dataSource = self
        // 设置代理
        //collectionView.delegate = self
    }
    
}


// MARK: - UICollectionViewDataSource
extension EmoticonView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    /// 返回分组数量 － 表情包的数量
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return packages.count
    }
    
    /// 返回每个表情包中的表情数量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return packages[section].emoticons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmoticonViewCellId, for: indexPath) as! EmoticonViewCell
        //cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.green
        //cell.emoticonButton.setTitle("\(indexPath.item)", for: .normal)
        cell.emoticon = packages[indexPath.section].emoticons[indexPath.item]
        return cell
    }
    
}




