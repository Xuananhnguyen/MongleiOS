//
//  SearchResultThemeVC.swift
//  Mongle
//
//  Created by 이예슬 on 7/8/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class SearchResultThemeVC: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var themeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        themeTableView.delegate = self
        themeTableView.dataSource = self
        themeTableView.reloadData()
        // Do any additional setup after loading the view.
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

extension SearchResultThemeVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let resultCountLabel = UILabel().then {
            $0.text = "검색된 테마 23개"
            $0.font = UIFont.systemFont(ofSize: 13)
        }
        let dividerView = UIView().then {
            $0.backgroundColor = .veryLightPink
        }
        let themeHeaderView = UIView().then {
            $0.addSubview(dividerView)
            $0.addSubview(resultCountLabel)
            $0.backgroundColor = .white
        }
        resultCountLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().offset(-260)
        }
        dividerView.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.height.equalTo(0.5)
            $0.top.equalTo(resultCountLabel.snp.bottom).offset(11)
            $0.bottom.equalToSuperview()
        }
        
        return themeHeaderView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
extension SearchResultThemeVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //검색어 색깔 설정하기
//        guard let text = .text else {
//             return
//         }
//
//         let attributedString = NSMutableAttributedString(string: themeTitleLabel.text!)
//         attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.softGreen,
//                                       range: (text as NSString).range(of: searchKeyWord))
//         themeTitleLabel.attributedText = attributedString
        guard let cell = themeTableView.dequeueReusableCell(withIdentifier: "searchResultThemeTVC", for: indexPath) as? SearchResultThemeTVC else { return UITableViewCell() }
        return cell
    }
    
}
