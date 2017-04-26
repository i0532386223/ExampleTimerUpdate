//
//  mainvc.swift
//  ExampleTimerUpdate
//
//  Created by Ivan Kramarchuk on 26.04.17.
//  Copyright © 2017 home. All rights reserved.
//

import UIKit

class mainvc: UIViewController {
    
    var header_label = UILabel()
    var time_label = UILabel()
    var button1 = UIButton()
    var button2 = UIButton()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        (header_label,time_label,button1,button2) = appDelegate.create_labels(view: self.view, text: "Main screen", show_buttons: true) as! (UILabel, UILabel, UIButton, UIButton)
        button1.addTarget(self, action:#selector(click1), for:.touchUpInside)
        button2.addTarget(self, action:#selector(click2), for:.touchUpInside)
    }
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(update_new_date(notification:)), name: Notification.Name("update_new_date"), object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }

    func click1(sender:UIButton!)
    {
        performSegue(withIdentifier: "goto1", sender: nil)
    }
    func click2(sender:UIButton!)
    {
        performSegue(withIdentifier: "goto2", sender: nil)
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
       
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
