//
//  HuliPizzaApp.swift
//  HuliPizza
//
//  Created by Jonathan Jiles on 8/23/24
//

import SwiftUI

@main
struct HuliPizzaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(menu:MenuModel().menu)
        }
    }
}
