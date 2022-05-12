//
//  AddAlertViewController.swift
//  drinkWaterAlarm
//
//  Created by jiyun moon on 2022/05/12.
//

import Foundation
import UIKit

class AddAlertViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var pickedDate: ((_ date: Date) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func dismissButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        pickedDate?(datePicker.date)
        self.dismiss(animated: true, completion: nil)
    }
    
}
