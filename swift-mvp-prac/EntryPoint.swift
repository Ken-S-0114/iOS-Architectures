//
//  EntryPoint.swift
//  swift-mvp-prac
//
//  Created by 佐藤賢 on 2018/03/19.
//  Copyright © 2018年 佐藤賢. All rights reserved.
//

import UIKit

struct EntryPoint {
  func main() -> UIViewController {
    let view = CatListVC()
    view.presenter = CatPresenterImpl(view: view)
    
    return view
  }
}
