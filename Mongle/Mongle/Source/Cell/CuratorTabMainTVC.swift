//
//  CuratorTabMainTVC.swift
//  Mongle
//
//  Created by 이예슬 on 7/13/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class CuratorTabMainTVC: UITableViewCell {
    
    @IBOutlet weak var themeTitleImageView: UIImageView!
    @IBOutlet weak var themeTitleLabel: UILabel!
    @IBOutlet weak var themeCuratorCountLabel: UILabel!
    @IBOutlet weak var curatorListCollectionView: UICollectionView!
    
    var selectSentenceDelegate: ((_ viewControllers: UIViewController) -> ()) = { _ in }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        curatorListCollectionView.delegate = self
        curatorListCollectionView.dataSource = self
        
        themeTitleLabel.text = "흔들리는 꽃들 속에서 네 샴푸향이 느껴진거야 스쳐 지나간건가 뒤돌아보는 문장"
        themeCuratorCountLabel.text = "큐레이터 53명"
        // Initialization code
    }
   
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//curatorListCollectionView
extension CuratorTabMainTVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let curatorInfoVC = UIStoryboard(name:"CuratorTabInfo",bundle:nil).instantiateViewController(identifier: "CuratorTabInfoVC") as? CuratorTabInfoVC else {
            return
        }
        selectSentenceDelegate(curatorInfoVC)
    }
}
extension CuratorTabMainTVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 375, height: 120)
    }
    //cell content inset 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    //cell 상 하 간격 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    //cell 좌 우 간격 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
extension CuratorTabMainTVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CuratorListCVC", for: indexPath) as? CuratorListCVC else{
            return UICollectionViewCell()
        }
        return cell
    }
}
