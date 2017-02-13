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
		updateDisplay()
	}

	@IBOutlet weak var unitsLabel: UILabel!
	@IBOutlet weak var outputLabel: UILabel!
	var unitConversions = [String: Float]()
	var units = [String]()
	var convertedAmount: Float = 0.0
	@IBOutlet weak var inputValue: UITextField!
	@IBOutlet weak var fromPicker: UIPickerView!
	@IBOutlet weak var toPicker: UIPickerView!
	
	@IBAction func convertPressed(_ sender: UIButton) {
		convertUnits()
	}
	
	func updateDisplay() {
		unitsLabel.text = units[toPicker.selectedRow(inComponent: 0)]
		outputLabel.text = String(convertedAmount)
		
	}
	
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
	
	func convertUnits()
	{
		let numberFormatter = NumberFormatter()
		// get out if no number was entered
		if inputValue.text == ""
		{
			updateDisplay()
			return
		}
		// if an invalid number is entered, alert the user
		if (numberFormatter.number(from: inputValue.text!)?.floatValue) == nil {
			let alertController = UIAlertController(title: "Invalid Amount", message: "Please enter a valid amount", preferredStyle: .alert)
			let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
			alertController.addAction(action)
			present(alertController, animated: true, completion: nil)
			updateDisplay()
			return
		}
		// get amount
		let input = numberFormatter.number(from: inputValue.text!)?.floatValue
		// get from unit conversion
		let fromUnitConversion = unitConversions[units[fromPicker.selectedRow(inComponent: 0)]]!
		// convert to meters
		let inputInMeters = input! * fromUnitConversion
		// get to unit conversion
		let toUnitConversion = unitConversions[units[toPicker.selectedRow(inComponent: 0)]]!
		// convert to to unit
		convertedAmount = Float(inputInMeters / toUnitConversion)
		inputValue.resignFirstResponder()
		updateDisplay()
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

