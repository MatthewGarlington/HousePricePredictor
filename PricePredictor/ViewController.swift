//
//  ViewController.swift
//  PricePredictor
//
//  Created by Matthew Garlington on 6/10/20.
//  Copyright © 2020 Matthew Garlington. All rights reserved.
//

import UIKit
import CoreML

 class ViewController: UIViewController {
     @IBOutlet var stackView: UIStackView!

     @IBOutlet var numberOfRooms: UISegmentedControl!
     @IBOutlet var numberOfBathrooms: UISegmentedControl!
     @IBOutlet var garageCapacity: UISegmentedControl!
     @IBOutlet var yearBuiltLabel: UILabel!
     @IBOutlet var yearBuiltSlider: UISlider!
     @IBOutlet var sizeLabel: UILabel!
     @IBOutlet var sizeSlider: UISlider!
     @IBOutlet var condition: UISegmentedControl!
     @IBOutlet var result: UILabel!

     let model = HousePrices()

     override func viewDidLoad() {
         super.viewDidLoad()

         let spacing: CGFloat = 30
         stackView.setCustomSpacing(spacing, after: numberOfRooms)
         stackView.setCustomSpacing(spacing, after: numberOfBathrooms)
         stackView.setCustomSpacing(spacing, after: garageCapacity)
         stackView.setCustomSpacing(spacing, after: yearBuiltSlider)
         stackView.setCustomSpacing(spacing, after: sizeSlider)
         stackView.setCustomSpacing(spacing, after: condition)

         updatePrediction(self)
     }

     @IBAction func updatePrediction(_ sender: Any) {
         yearBuiltLabel.text = "Year Built: \(Int(yearBuiltSlider.value))"
         sizeLabel.text = "Size: \(Int(sizeSlider.value))"

         do {
             let prediction = try model.prediction(
                 bathrooms: Double(numberOfBathrooms.selectedSegmentIndex + 1),
                 cars: Double(garageCapacity.selectedSegmentIndex),
                 condition: Double(condition.selectedSegmentIndex),
                 rooms: Double(numberOfRooms.selectedSegmentIndex + 1),
                 size: Double(Int(sizeSlider.value)),
                 yearBuilt: Double(Int(yearBuiltSlider.value))
             )


             let formatter = NumberFormatter()
             formatter.numberStyle = .currency
             formatter.maximumFractionDigits = 0
             result.text = formatter.string(from: prediction.value as NSNumber) ?? ""
         } catch {
             print(error.localizedDescription)
         }
     }
 }

