//
//  EntryPoint.swift
//  swift-mvvm-prac
//
//  Created by 佐藤賢 on 2018/03/20.
//  Copyright © 2018年 佐藤賢. All rights reserved.
//

import UIKit

struct EntryPoint {
  func main() -> UIViewController {
    let view = CatListVC()
    view.viewModel = CatDefaultViewModel()
    
    return view
  }
}
