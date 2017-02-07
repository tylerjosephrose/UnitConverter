//
//  ViewController.swift
//  UnitConverter
//
//  Created by Tyler Rose on 2/7/17.
//  Copyright © 2017 Tyler Rose. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		loadUnits()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	var unitConversions = [String: Float]()
	var units = [String]()
	
	func loadUnits() {
		let filepath = Bundle.main.path(forResource: "Length", ofType: "plist")
		unitConversions = NSDictionary(contentsOfFile: filepath!) as! Dictionary<String, Float>
		let sortedUnits = unitConversions.sorted(by: sortUnits)
		for item in sortedUnits {
			units.append(item.key)
		}
	}
	
	func sortUnits(first: (key: String, value: Float), second: (key: String, value: Float)) -> Bool {
		return first.value > second.value
	}

	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return units.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return units[row]
	}

}

