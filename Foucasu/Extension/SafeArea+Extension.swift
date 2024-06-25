//
//  SafeArea+Extension.swift
//  Foucasu
//
//  Created by Wei Chu on 2024/6/20.
//

import Foundation
import SwiftUI

/*
 How to use?

 Given:
    - I'm in some SwiftUI view.
    - I want to get height of top safeArea.

 When:
    - Add this Environment in the view.  '@Environment(\.safeAreaInsets) var safeAreaInsets'

 Then:
    - And I can get height of top safeArea when used 'safeAreaInsets.top'.
 */

extension UIApplication {
    var keyWindow: UIWindow? {
        connectedScenes
            .compactMap {
                $0 as? UIWindowScene
            }
            .flatMap {
                $0.windows
            }
            .first {
                $0.isKeyWindow
            }
    }
}

private struct SafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
        UIApplication.shared.keyWindow?.safeAreaInsets.swiftUiInsets ?? EdgeInsets()
    }
}

private extension UIEdgeInsets {
    var swiftUiInsets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}

extension EnvironmentValues {
    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
}
