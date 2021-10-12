//
//  NextViewController.swift
//  YLInfiniteScrollView
//
//  Created by AlbertYuan on 2021/10/12.
//

import UIKit

class NextViewController: UIViewController {

    let imageArr = ["1.png","2.png","3.png","4.png"]

    let scrollPage = YLInfiniteScrollView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.size.width, height: 260))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
