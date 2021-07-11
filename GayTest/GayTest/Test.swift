//
//  Test.swift
//  GayTest
//
//  Created by Serega on 30.06.2021.
//

import Foundation
class Test: Identifiable {
    public static var name = ""
    public static var age = ""
    public static var history : [String] = []
    public static var IsGayHistory: [Bool] = []
    public static func LoadHistory() {
        history = UserDefaults.standard.stringArray(forKey: "history") ?? Test.history
    }
    public static func LoadIsGayHistory() {
        IsGayHistory = UserDefaults.standard.array(forKey: "isgayhistory") as? [Bool] ?? Test.IsGayHistory
    }
    public static func SaveIsGayHistory() {
        UserDefaults.standard.setValue(Test.IsGayHistory, forKey: "isgayhistory")
    }
    public static func SaveHistory() {
        UserDefaults.standard.setValue(Test.history, forKey: "history")
    }
    public static func LoadName() {
        name = UserDefaults.standard.string(forKey: "name") ?? ""
    }
    public static func LoadAge() {
        age = UserDefaults.standard.string(forKey: "age") ?? ""
    }
    public static func SaveName() {
        UserDefaults.standard.setValue(Test.name, forKey: "name")
    }
    public static func SaveAge() {
        UserDefaults.standard.setValue(Test.age, forKey: "age")
    }
    public static var IsHistoryEmpty : Bool {
        get {
            return history.count == 0
          }
    }
}
        
