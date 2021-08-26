//
//  Test.swift
//  GayTest
//
//  Created by Serega on 30.06.2021.
//

import Foundation
class Test: Identifiable {
    public static var testToOpen = TestOrientation.none
    public static var name = ""
    public static var age = ""
    public static var history : [String] = []
    public static var IsOrientationHistory: [Bool] = []
    public enum  TestOrientation {
        case gay
      case lesbian
        case none
    }
    public static func LoadHistory(orientation: TestOrientation) {
        history = UserDefaults.standard.stringArray(forKey: orientation == TestOrientation.gay ? "Ghistory": "Lhistory") ?? []
    }
    public static func LoadIsOrientationHistory(orientation: TestOrientation) {
        IsOrientationHistory = UserDefaults.standard.array(forKey: orientation == TestOrientation.gay ? "isgayhistory" : "islesbhistory") as? [Bool] ?? []
    }
    public static func SaveIsOrientationHistory(orientation: TestOrientation) {
        UserDefaults.standard.setValue(Test.IsOrientationHistory, forKey:  orientation == TestOrientation.gay ? "isgayhistory" : "islesbhistory")
    }
    public static func SaveHistory(orientation: TestOrientation) {
        UserDefaults.standard.setValue(Test.history, forKey: orientation == TestOrientation.gay ? "Ghistory" : "Lhistory")
    }
    public static func LoadName(orientation: TestOrientation) {
        name = UserDefaults.standard.string(forKey: orientation == TestOrientation.gay ? "Gname" : "Lname") ?? ""
    }
    public static func LoadAge(orientation: TestOrientation) {
        age = UserDefaults.standard.string(forKey: orientation == TestOrientation.gay ? "Gage" : "Lage") ?? ""
    }
    public static func SaveName(orientation: TestOrientation) {
        UserDefaults.standard.setValue(Test.name, forKey: orientation == TestOrientation.gay ? "Gname" : "Lname")
    }
    public static func SaveAge(orientation: TestOrientation) {
        UserDefaults.standard.setValue(Test.age, forKey:  orientation == TestOrientation.gay ? "Gage" : "Lage")
    }
    public static var IsHistoryEmpty : Bool {
        get {
            return history.count == 0
          }
    }
}
        
