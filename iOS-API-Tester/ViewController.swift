//
//  ViewController.swift
//  iOS-API-Tester
//
//  Created by Michael Vartanian on 8/29/20.
//  Copyright © 2020 Michael Vartanian. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet var routeLabel: UILabel!
    @IBOutlet var routePickerView: UIPickerView!
    @IBOutlet var routeButton: UIButton!
    @IBOutlet var routeScrollView: UIScrollView!

    let customRoutes = [String]()

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        customRoutes.count
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

