//
//  FLPlugin.swift
//  Runner
//
//  Created by datvq24 on 11/10/24.
//

import Flutter
import UIKit

class FLPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let factory = FLNativeViewFactory(messenger: registrar.messenger())
        registrar.register(factory, withId: "custom_view")
    }
}
