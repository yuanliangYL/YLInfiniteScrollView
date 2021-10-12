//
//  TestCell.swift
//  YLInfiniteScrollView
//
//  Created by AlbertYuan on 2021/10/12.
//

import UIKit

class TestCell: UITableViewCell {

    let imageArr = ["1.png","2.png","3.png","4.png"]

    let scrollPage = YLInfiniteScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 260))

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

                scrollPage.imagesData = imageArr
                scrollPage.autoScroll = true
                scrollPage.scrollInterval = 4.0
        //        scrollPage.delegate = self
        contentView.addSubview(scrollPage)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
