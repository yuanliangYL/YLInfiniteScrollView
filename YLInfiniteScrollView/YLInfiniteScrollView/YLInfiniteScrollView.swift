//
//  YLInfinateScrollView.swift
//  YLInfiniteScrollView
//
//  Created by AlbertYuan on 2021/10/11.



// UIcollectionView  Timer  Date综合


import UIKit

protocol YLInfiniteScrollViewDelegate {
    func didSelectedRow(indexpath: IndexPath)
}


class YLInfiniteScrollView: UIView {

    var delegate:YLInfiniteScrollViewDelegate?

    // MARK: -- lazy
    lazy var pageControll: UIPageControl = {

        let pagecontroll = UIPageControl()
        pagecontroll.backgroundColor = UIColor.clear
        pagecontroll.currentPage = 0
        pagecontroll.currentPageIndicatorTintColor = .yellow
        pagecontroll.tintColor = .gray
        return pagecontroll

    }()

    lazy var scrollCollectionView:UICollectionView  = {

        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.itemSize = self.frame.size
        flowlayout.minimumLineSpacing = 0
        flowlayout.minimumInteritemSpacing = 0
        flowlayout.scrollDirection = .horizontal

        let scrollPage = UICollectionView(frame: self.bounds, collectionViewLayout: flowlayout)
        scrollPage.showsVerticalScrollIndicator = false
        scrollPage.showsHorizontalScrollIndicator = false
        scrollPage.isScrollEnabled = true
        scrollPage.dataSource = self
        scrollPage.delegate = self
        scrollPage.isPagingEnabled = true
        scrollPage.register(YLInfiniteScrollCell.self, forCellWithReuseIdentifier:  NSStringFromClass(YLInfiniteScrollCell.self))
        scrollPage.bounces = false
        return scrollPage

    }()

    var scrollInterval: TimeInterval = 3.0

    // MARK: -- 定时器
    var timer:Timer?

    // MARK: -- 是否自动滚动
    var autoScroll: Bool = false {
        didSet{
            //[NSDate distantFuture]设置定时器未来永久在开启，相当于单前关闭
            //定时器激活时间设置：几秒后或则永久的未来
            let fireDate =  autoScroll ? Date(timeIntervalSinceNow: scrollInterval) : Date.distantFuture
            timer?.fireDate = fireDate as Date
        }
    }

    // MARK: -- 点击回调

    // MARK: -- 数据
    var imagesData:[String] = [""] {
        didSet{

            pageControll.numberOfPages = imagesData.count

            //首位修改数据
            if imagesData.count != 0{
                let first = imagesData.first!
                let last = imagesData.last!
                imagesData.append(first)
                imagesData.insert(last, at: 0)
            }

            scrollCollectionView.reloadData()
            //初始滚动到第二页
            scrollCollectionView.setContentOffset(CGPoint(x: UIScreen.main.bounds.width, y: 0), animated: false)
        }
    }


    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(scrollCollectionView)
        self.addSubview(pageControll)

        //定时器赋值:默认添加的方式在翻动是定时器无起作用
//        timer = Timer.scheduledTimer(timeInterval: scrollInterval, target: self, selector: #selector(scrollViewByTime), userInfo: nil, repeats: true)
        timer = Timer.init(timeInterval: scrollInterval, target:self, selector:  #selector(scrollViewByTime), userInfo: nil, repeats: true)
        if let time =  timer{
            RunLoop.current.add(time, forMode: .common)
            time.fireDate = NSDate.distantFuture//不激活
        }

    }

    override func layoutSubviews() {

        let width = self.frame.size.width
        let height = self.frame.size.height

        pageControll.frame = CGRect(x: width / 4, y: height - 30, width: width / 2, height: 30)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    deinit{
        timer?.invalidate()
    }

}

extension YLInfiniteScrollView: UICollectionViewDelegate,UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:YLInfiniteScrollCell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(YLInfiniteScrollCell.self), for: indexPath) as! YLInfiniteScrollCell
        cell.placeholderImage = "information_img_2-1"
        cell.imageInfo = imagesData[indexPath.row]

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let newIndex = IndexPath(item: indexPath.row - 1, section: indexPath.section)
        delegate?.didSelectedRow(indexpath: newIndex)

    }
}

extension YLInfiniteScrollView:UIScrollViewDelegate{

    //将要减速停止时://手动拖拽结束
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        cycleScroll()
        if autoScroll{
            ////拖拽动作后间隔3s继续轮播
            timer?.fireDate = Date(timeIntervalSinceNow: scrollInterval)
        }
    }

    //自动轮播结束
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        cycleScroll()
    }


    func cycleScroll(){
        //得到page
        let page = (Int)(scrollCollectionView.contentOffset.x / UIScreen.main.bounds.size.width)

        if page == 0{
            //最左侧:核心
            scrollCollectionView.setContentOffset(CGPoint(x: UIScreen.main.bounds.width * (CGFloat)(imagesData.count - 2) , y: 0), animated: false)
            //scrollView.contentOffset = CGPoint(x: UIScreen.main.bounds.width * (CGFloat)(imagesData.count - 2) , y: 0)
            pageControll.currentPage = imagesData.count - 2

        }else if page == imagesData.count - 1{

            //最右侧
            scrollCollectionView.contentOffset = CGPoint(x: UIScreen.main.bounds.width  , y: 0)
            pageControll.currentPage = 0
        }else{
            pageControll.currentPage = page - 1
        }
    }
}

extension YLInfiniteScrollView{

    @objc func scrollViewByTime(){
        //        print(#function)
        if scrollCollectionView.isDragging {
            return
        }

        //一直向前滚动
        let targetX = scrollCollectionView.contentOffset.x + scrollCollectionView.bounds.width
        scrollCollectionView .setContentOffset(CGPoint(x: targetX, y: 0), animated: true)

    }
}
