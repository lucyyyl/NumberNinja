//
//  UIWindow+Extension.swift
//  Wordle
//
//  Created by Lucy Llewellyn on 04/10/2022.
//

import UIKit

extension UIWindow {
    static var key: UIWindow? {
        guard let scene = UIApplication.shared.connectedScenes.first,
              let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
              let window = windowSceneDelegate.window else {
                return nil
        }
        return window
    }
}
