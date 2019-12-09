//
//  detailsViewController.swift
//  employee_task
//
//  Created by Mac on 07/12/19.
//  Copyright © 2019 Varsha. All rights reserved.
//

import UIKit

class detailsViewController: UIViewController
{


    @IBOutlet var eidlabel: UILabel!

    @IBOutlet var enamelabel: UILabel!

    @IBOutlet var esallabel: UILabel!

    @IBOutlet var eagelabel: UILabel!
    
    var detailarray:[Employee]=[]
    
    var streidlabel:String=""
    var strenamelabel:String=""
    var strempsallabel:String=""
    var stragelabel:String=""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        eidlabel.text=streidlabel
        enamelabel.text=strenamelabel
        esallabel.text=strempsallabel
       eagelabel.text=stragelabel
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
