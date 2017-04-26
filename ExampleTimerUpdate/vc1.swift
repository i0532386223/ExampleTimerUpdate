//
//  vc1.swift
//  ExampleTimerUpdate
//
//  Created by Ivan Kramarchuk on 26.04.17.
//  Copyright © 2017 home. All rights reserved.
//

import UIKit

class vc1: UIViewController {

    var header_label = UILabel()
    var time_label = UILabel()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (header_label,time_label,_,_) = appDelegate.create_labels(view: self.view, text: "vc1", show_buttons: false)
    }
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(update_new_date(notification:)), name: Notification.Name("update_new_date"), object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    func update_new_date(notification: Notification){
        if let userInfo = notification.userInfo as? [String: Any]
        {
            if let date = userInfo["date"] as? String {
                time_label.text = date
                appDelegate.animate_update(view: time_label)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
