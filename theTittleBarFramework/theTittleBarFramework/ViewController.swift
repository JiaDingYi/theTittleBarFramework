//
//  ViewController.swift
//  theTittleBarFramework
//
//  Created by 甲丁乙_ on 2016/12/5.
//  Copyright © 2016年 甲丁乙_. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        
        // 1.搞定frame
        let pageViewFrame = CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height - 64)
        
        // 2.所有的标题
        //        let titles = ["推荐", "手游", "娱乐", "游戏", "趣玩"]
        
        let titles = ["推荐", "手游玩法大全", "娱乐手", "游戏游戏", "趣玩", "游戏游戏", "趣玩", "趣玩", "趣玩", "趣玩", "趣玩", "趣玩", "趣玩", "趣玩"]
        
        // 3.titleView的样式
        let style = WtittleStyle()
        style.tittleHeight = 44
        style.isScrollEnable = true
        style.isNeedScale = true
        style.isShowCover = true
        
        // 4.初始化所有的子控制器
        var childVcs = [UIViewController]()
        for _ in 0..<titles.count {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.randomColor()
            childVcs.append(vc)
        }
        
        // 5.创建HYPageView
        let pageView = WpageView(frame: pageViewFrame, tittles: titles, style: style, childVcs: childVcs, parentVc: self)
        
        // 6.将pageView添加到控制器的view中
        view.addSubview(pageView)
    }
}


