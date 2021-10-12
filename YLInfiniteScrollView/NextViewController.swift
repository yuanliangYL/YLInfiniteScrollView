//
//  NextViewController.swift
//  YLInfiniteScrollView
//
//  Created by AlbertYuan on 2021/10/12.
//

import UIKit

class NextViewController: UIViewController {

    let imageArr:[String] = []
    let scrollPage = YLInfiniteScrollView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.size.width, height: 260))


    override func viewDidLoad() {
        super.viewDidLoad()

        scrollPage.imagesData = imageArr
        scrollPage.autoScroll = true
        scrollPage.scrollInterval = 4.0
//        scrollPage.delegate = self
        view.addSubview(scrollPage)
        view.backgroundColor = .yellow
    }

    deinit{
        print("delloc")
    }


}
