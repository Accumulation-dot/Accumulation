//
//  File.swift
//  
//
//  Created by Mario on 2022/9/22.
//

import UIKit

public class UIFactory {
    public static func view<T: NSObject>(_ value: ((T) -> Void)?) -> T {
        let view = T()
        value?(view)
        return view
    }

    public static func createLabel() -> UILabel {
        let label: UILabel = view { label in
            label.textColor = .red
        }
        return label
    }

    public static func createButton() -> UIButton {

        let button: UIButton = view { button in
            button.configuration
        }

        return button
    }
}



