//
//  ViewController.swift
//  YLInfiniteScrollView
//
//  Created by AlbertYuan on 2021/10/11.
//

import UIKit

class ViewController: UIViewController {

//    let imageArr = ["1.png","2.png","3.png","4.png"]

    @IBOutlet weak var tb: UITableView!
    
//    let scrollPage = YLInfiniteScrollView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.size.width, height: 260))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

//        scrollPage.imagesData = imageArr
//        scrollPage.autoScroll = true
//        scrollPage.scrollInterval = 4.0
//        scrollPage.delegate = self
//        view.addSubview(scrollPage)

        tb.register(TestCell.self, forCellReuseIdentifier: "recell")
        tb.register(UITableViewCell.self, forCellReuseIdentifier: "rec")

    }

//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        navigationController?.pushViewController(NextViewController(), animated: true)
//    }
}

//extension ViewController:YLInfiniteScrollViewDelegate{
//    func didSelectedRow(indexpath: IndexPath) {
//        print("currnet selected is " + imageArr[indexpath.row])
//    }
//}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell:TestCell = tableView.dequeueReusableCell(withIdentifier: "recell", for: indexPath) as! TestCell
            return cell
        }else{
            let cell :UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "rec", for: indexPath)
            cell.textLabel?.text = "\(indexPath.row)"
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 260
        }
        else{
            return 80
        }
    }
}
