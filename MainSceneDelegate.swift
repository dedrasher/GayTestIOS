//
//  MainSceneDelegate.swift
//  MainSceneDelegate
//
//  Created by Serega on 26.08.2021.
//

import UIKit

final class MainSceneDelegate: UIResponder, UIWindowSceneDelegate {
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if connectionOptions.shortcutItem != nil{
            Test.testToOpen = connectionOptions.shortcutItem?.type == "QuickAction.OpenGayTest" ? .gay : .lesbian
        }
    }
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        Test.testToOpen = shortcutItem.type == "QuickAction.OpenGayTest" ? .gay : .lesbian
    }
}
