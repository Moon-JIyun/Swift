//
//  ViewController.swift
//  NewsApp
//
//  Created by jiyun moon on 2021/12/27.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var searchText: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchText.setPlaceholderColor(color: .systemGray)
    }

    @IBAction func SearchButton(_ sender: UIButton) {
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "ArticleTableView") as! ArticleTableView
        pushVC.queryValue = searchText.text!
        self.navigationController?.pushViewController(pushVC, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ArticleTableView" {
            let vc = segue.destination as! ArticleTableView
            vc.queryValue = searchText.text!
        }
    }
}

extension UITextField {
    func setPlaceholderColor(color: UIColor) {
        attributedPlaceholder = NSAttributedString(string: "검색어를 입력하세요", attributes: [.foregroundColor: color])
    }
}

