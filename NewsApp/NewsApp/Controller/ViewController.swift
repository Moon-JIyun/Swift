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
        // Do any additional setup after loading the view.
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

