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

    let customRoutes = CustomRoutes()

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        customRoutes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return customRoutes.nameOfRoute(at: row)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        routePickerView.dataSource = self
        routePickerView.delegate = self
        
        routeButton.layer.cornerRadius = 8.0
        routeScrollView.layer.cornerRadius = 8.0
        routePickerView.layer.cornerRadius = 8.0
        routePickerView.layer.borderWidth = 0.5
        routePickerView.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        routeLabel.text = "asdlfkjasdlfkjsdlfkjasdlkfjasldkfjaslkdfjalskdfjalskdjflakdsjfklasdjfalksdfjalksdjfklasjfdklajfdlkajdfklajdflkjasdlfkjasldfkjalsdkfjalsdkfjalkdsfjalkdsjflakdsjflaskdjfalkdsjflakdsjfalkdjflakdjflkadjflkajsdkljafksdjflkajdfkajdfsklajdfklajfdlkasjflaksdjfalksdjflaksdjfklasjdflkjasdkfajdklfjalkdkfjalsdkfjalksdjflakdjfalkjfaldskjfalskdjfalkdsjfalkdsfjklajsdflkajdskljfklajdasklfjkalsdjfklasjlkfjaklsdjfalkjfsalkfj"
    }
    
    @IBAction func performRequest(_ sender: UIButton) {
        customRoutes.performRequest(index: routePickerView.selectedRow(inComponent: 0)) { response, data, error in
            var text = ""
            if let error = error {
                text += error.localizedDescription
            } else {
                response.allHeaderFields.keys.forEach { key in
                    text += "\(key): \(response.allHeaderFields[key] ?? String())\n"
                }
                text += "\n"
                text += String(data: data, encoding: .utf8) ?? ""
            }
            DispatchQueue.main.async {
                self.routeLabel.text = text
                self.routeLabel.sizeToFit()
                self.routeScrollView.contentOffset = CGPoint(x: 0, y: 0)
            }
        }
    }
}
