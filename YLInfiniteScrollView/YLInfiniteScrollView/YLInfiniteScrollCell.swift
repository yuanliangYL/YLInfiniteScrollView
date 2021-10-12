//
//  ScrollpageCollectionViewCell.swift
//  YLInfiniteScrollView
//
//  Created by AlbertYuan on 2021/10/11.
//

import UIKit

class YLInfiniteScrollCell: UICollectionViewCell {

    lazy var image:UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    var placeholderImage:String?

    var imageInfo:String = ""{
        didSet{
            image.image =  UIImage(named: placeholderImage ?? "")
            DispatchQueue.global().async {
                let newimage = UIImage(named: self.imageInfo)
                DispatchQueue.main.async {
                    self.image.image = newimage
                }
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        clipsToBounds = true

        let color = UIColor(red: CGFloat((arc4random()%256)) / 255.0, green:  CGFloat((arc4random()%256)) / 255.0, blue:  CGFloat((arc4random()%256)) / 255.0, alpha: 1.0)
        contentView.backgroundColor = color
        self.addSubview(image)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        image.frame = self.bounds
    }
}
