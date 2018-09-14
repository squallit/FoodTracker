//
//  DetailViewController.swift
//  FoodTracker
//
//  Created by Son Luu on 2/16/15.
//  Copyright (c) 2015 Son Luu. All rights reserved.
//

import UIKit
import HealthKit

class DetailViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var usdaItem : USDAItem?
    override func viewDidLoad() {
        super.viewDidLoad()

        requestAuthorizationForHealthStore()
        // Do any additional setup after loading the view.
        if usdaItem != nil {
            textView.attributedText = createAttributedString(usdaItem!)
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        NotificationCenter.default.addObserver(self, selector: #selector(DetailViewController.usdaItemDidComplete(_:)), name: NSNotification.Name(rawValue: kUSDAItemCompleted), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    

    @IBAction func eatItBarButtonItemPressed(_ sender: UIBarButtonItem) {
        self.saveFoodItem(usdaItem!)
    }

    func usdaItemDidComplete(_ notification: Notification) {
        print("usdaItemDidComplete in DetailViewController")
        usdaItem = notification.object as? USDAItem
        if self.isViewLoaded && self.view.window != nil {
            textView.attributedText = createAttributedString(usdaItem!)
        }
    }
    
    func createAttributedString (_ usdaItem: USDAItem!) -> NSAttributedString {
        let itemAttributedString = NSMutableAttributedString()
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = NSTextAlignment.center
        centeredParagraphStyle.lineSpacing = 10.0
        let titleAttributesDictionary = [
            NSForegroundColorAttributeName : UIColor.black,
            NSFontAttributeName : UIFont.boldSystemFont(ofSize: 22.0),
            NSParagraphStyleAttributeName : centeredParagraphStyle]
        let titleString = NSAttributedString(string: "\(usdaItem.name)\n", attributes: titleAttributesDictionary)
        itemAttributedString.append(titleString)
        
        let leftAllignedParagraphStyle = NSMutableParagraphStyle()
        leftAllignedParagraphStyle.alignment = NSTextAlignment.left
        leftAllignedParagraphStyle.lineSpacing = 20.0
        
        let styleFirstWordAttributesDictionary = [
            NSForegroundColorAttributeName : UIColor.black,
            NSFontAttributeName : UIFont.boldSystemFont(ofSize: 18.0),
            NSParagraphStyleAttributeName : leftAllignedParagraphStyle]
        let style1AttributesDictionary = [
            NSForegroundColorAttributeName : UIColor.darkGray,
            NSFontAttributeName : UIFont.systemFont(ofSize: 18.0),
            NSParagraphStyleAttributeName : leftAllignedParagraphStyle]
        let style2AttributesDictionary = [
            NSForegroundColorAttributeName : UIColor.lightGray,
            NSFontAttributeName : UIFont.systemFont(ofSize: 18.0),
            NSParagraphStyleAttributeName : leftAllignedParagraphStyle]
        
        let calciumTitleString = NSAttributedString(string: "Calcium  ", attributes: styleFirstWordAttributesDictionary)
        let calciumBodyString = NSAttributedString(string: "\(usdaItem.calcium)% \n", attributes: style1AttributesDictionary)
        itemAttributedString.append(calciumTitleString)
        itemAttributedString.append(calciumBodyString)
        let carbohydrateTitleString = NSAttributedString(string: "Carbohydrate  ", attributes: styleFirstWordAttributesDictionary)
        let carbohydrateBodyString = NSAttributedString(string: "\(usdaItem.carbohydrate)% \n", attributes: style2AttributesDictionary)
        itemAttributedString.append(carbohydrateTitleString)
        itemAttributedString.append(carbohydrateBodyString)
        let cholesterolTitleString = NSAttributedString(string: "Cholesterol  ", attributes: styleFirstWordAttributesDictionary)
        let cholesterolBodyString = NSAttributedString(string: "\(usdaItem.cholesterol)% \n", attributes: style1AttributesDictionary)
        itemAttributedString.append(cholesterolTitleString)
        itemAttributedString.append(cholesterolBodyString)
        
        // Energy
        let energyTitleString = NSAttributedString(string: "Energy  ", attributes: styleFirstWordAttributesDictionary)
        let energyBodyString = NSAttributedString(string: "\(usdaItem.energy)% \n", attributes: style2AttributesDictionary)
        itemAttributedString.append(energyTitleString)
        itemAttributedString.append(energyBodyString)
        
        // Fat Total
        let fatTotalTitleString = NSAttributedString(string: "FatTotal  ", attributes: styleFirstWordAttributesDictionary)
        let fatTotalBodyString = NSAttributedString(string: "\(usdaItem.fatTotal)% \n", attributes: style1AttributesDictionary)
        itemAttributedString.append(fatTotalTitleString)
        itemAttributedString.append(fatTotalBodyString)
        
        // Protein
        let proteinTitleString = NSAttributedString(string: "Protein  ", attributes: styleFirstWordAttributesDictionary)
        let proteinBodyString = NSAttributedString(string: "\(usdaItem.protein)% \n", attributes: style2AttributesDictionary)
        itemAttributedString.append(proteinTitleString)
        itemAttributedString.append(proteinBodyString)
        
        // Sugar
        let sugarTitleString = NSAttributedString(string: "Sugar  ", attributes: styleFirstWordAttributesDictionary)
        let sugarBodyString = NSAttributedString(string: "\(usdaItem.sugar)% \n", attributes: style1AttributesDictionary)
        itemAttributedString.append(sugarTitleString)
        itemAttributedString.append(sugarBodyString)
        
        // Vitamin C
        let vitaminCTitleString = NSAttributedString(string: "Vitamin C  ", attributes: styleFirstWordAttributesDictionary)
        let vitaminCBodyString = NSAttributedString(string: "\(usdaItem.vitaminC)% \n", attributes: style2AttributesDictionary)
        itemAttributedString.append(vitaminCTitleString)
        itemAttributedString.append(vitaminCBodyString)
        
        
        
        return itemAttributedString
    }
    
    func requestAuthorizationForHealthStore() {
        let dataTypesToWrite = [
            HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryCalcium),
            HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryCarbohydrates),
            HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryCholesterol),
            HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryEnergyConsumed),
            HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryFatTotal),
            HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryProtein),
            HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietarySugar),
            HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryVitaminC)
        ]
        let dataTypesToRead = [
            HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryCalcium),
            HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryCarbohydrates),
            HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryCholesterol),
            HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryEnergyConsumed),
            HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryFatTotal),
            HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryProtein),
            HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietarySugar),
            HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryVitaminC)
        ]
        
        var store: HealthStoreConstant = HealthStoreConstant()
        store.healthStore?.requestAuthorization(toShare: NSSet(array: dataTypesToWrite) as! Set<HKSampleType>, read: NSSet(array: dataTypesToRead) as! Set<HKObjectType>, completion: { (success, error) -> Void in
            if success {
                print("User completed authorization request.")
            }
            else {
                print("User canceled the request \(error)")
            }
        })
    }
    
    func saveFoodItem (_ foodItem : USDAItem) {
        if HKHealthStore.isHealthDataAvailable() {
            let timeFoodWasEntered = Date()
            let foodMetaData = [
                HKMetadataKeyFoodType : foodItem.name,
                "HKBrandName" : "USDAItem",
                "HKFoodTypeID" : foodItem.idValue
            ]
            
            let energyUnit = HKQuantity(unit: HKUnit.kilocalorie(), doubleValue: (foodItem.energy as NSString).doubleValue)
            let calories = HKQuantitySample(type: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryEnergyConsumed)!, quantity: energyUnit, start: timeFoodWasEntered, end: timeFoodWasEntered, metadata : foodMetaData)
            
            let calciumUnit = HKQuantity(unit: HKUnit.gramUnit(with: HKMetricPrefix.milli), doubleValue: (foodItem.calcium as NSString).doubleValue)
            
            let calcium = HKQuantitySample(type: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryCalcium)!, quantity: calciumUnit, start: timeFoodWasEntered, end: timeFoodWasEntered, metadata : foodMetaData)
            
            let carbohydrateUnit = HKQuantity(unit: HKUnit.gram(), doubleValue: (foodItem.carbohydrate as NSString).doubleValue)
            
            let carbohydrates = HKQuantitySample(type: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryCarbohydrates)!, quantity: carbohydrateUnit, start: timeFoodWasEntered, end: timeFoodWasEntered, metadata : foodMetaData)
            
            let fatTotalUnit = HKQuantity(unit: HKUnit.gram(), doubleValue: (foodItem.fatTotal as NSString).doubleValue)
            
            let fatTotal = HKQuantitySample(type: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryFatTotal)!, quantity: fatTotalUnit, start: timeFoodWasEntered, end: timeFoodWasEntered, metadata : foodMetaData)
            
            let proteinUnit = HKQuantity(unit: HKUnit.gram(), doubleValue: (foodItem.protein as NSString).doubleValue)
            
            let protein = HKQuantitySample(type: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryProtein)!, quantity: proteinUnit, start: timeFoodWasEntered, end: timeFoodWasEntered, metadata : foodMetaData)
            
            let sugarUnit = HKQuantity(unit: HKUnit.gram(), doubleValue: (foodItem.sugar as NSString).doubleValue)
            
            let sugar = HKQuantitySample(type: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietarySugar)!, quantity: sugarUnit, start: timeFoodWasEntered, end: timeFoodWasEntered, metadata : foodMetaData)
            
            let vitaminCUnit = HKQuantity(unit: HKUnit.gramUnit(with: HKMetricPrefix.milli), doubleValue: (foodItem.vitaminC as NSString).doubleValue)
            
            let vitaminC = HKQuantitySample(type: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryVitaminC)!, quantity: vitaminCUnit, start: timeFoodWasEntered, end: timeFoodWasEntered, metadata : foodMetaData)
            
            let cholesterolUnit = HKQuantity(unit: HKUnit.gramUnit(with: HKMetricPrefix.milli), doubleValue: (foodItem.cholesterol as NSString).doubleValue)
            
            let cholesterol = HKQuantitySample(type: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryCholesterol)!, quantity: cholesterolUnit, start: timeFoodWasEntered, end: timeFoodWasEntered, metadata : foodMetaData)
            
            let foodDataSet = NSSet(array: [calories, calcium, carbohydrates, cholesterol, fatTotal, protein, sugar, vitaminC])
            let foodCorelation = HKCorrelation(type: HKCorrelationType.correlationType(forIdentifier: HKCorrelationTypeIdentifier.food)!, start: timeFoodWasEntered, end: timeFoodWasEntered, objects: foodDataSet as! Set<HKSample>, metadata : foodMetaData)
            var store:HealthStoreConstant = HealthStoreConstant()
            store.healthStore?.save(foodCorelation, withCompletion: { (success, error) -> Void in
                if success {
                    print("saved successfully")
                }
                else {
                    print("Error Occured: \(error)")
                }
            })
            
            
            
            
            
        }
    }

}
