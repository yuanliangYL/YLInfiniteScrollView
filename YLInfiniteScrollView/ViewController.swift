//
//  ViewController.swift
//  YLInfiniteScrollView
//
//  Created by AlbertYuan on 2021/10/11.
//

import UIKit

class ViewController: UIViewController {

    let imageArr = ["1.png","2.png","3.png","4.png"]

    let scrollPage = YLInfiniteScrollView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.size.width, height: 260))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        scrollPage.imagesData = imageArr
        scrollPage.autoScroll = true
        scrollPage.scrollInterval = 4.0
        scrollPage.delegate = self
        view.addSubview(scrollPage)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        navigationController?.pushViewController(NextViewController(), animated: true)
    }
}

extension ViewController:YLInfiniteScrollViewDelegate{
    func didSelectedRow(indexpath: IndexPath) {
        print("currnet selected is " + imageArr[indexpath.row])
    }
}

