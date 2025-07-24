//
//  MenuView.swift
//  HuliPizza
//
//  Created by Jonathan Jiles on 8/23/24
//

import SwiftUI

let meshGradient:MeshGradient = MeshGradient(
    width: 4,
    height: 3,
    points: [
        [0.0,0.0],[0.25,0.0],[0.66,0.0],[1.0,0.0],
        [0.0,0.5],[0.5,0.8],[0.66,0.8],[1.0,0.3],
        [0.0,1.0],[0.25,1.0],[0.66,1.0],[1.0,1.0]
        ],
    colors: [
        sky,sky,sky,sky,
        surf,sky,sky,sky,
        surf,surf,surf,surf
    ]
)

struct MenuView: View {
    var menu:[MenuItem]
    @Binding var selectedItem:MenuItem
    @Environment(OrderModel.self) var orders:OrderModel
    @Binding var path:NavigationPath
    var body: some View {
        List(MenuCategory.allCases, id:\.self){ category in
            Section {
                ForEach(menu.filter({$0.category == category})){ item in
                    NavigationLink(value:item){
                        MenuRowView(item: item)
                            .listRowStyleModifier(imageID: item.id)
                            .listRowBackground(Color.clear)
                    }
                }
            } header:{
                Text(category.rawValue)
            }
        }.scrollContentBackground(.hidden)
            .navigationDestination(for: MenuItem.self) { selected in
                MenuItemView(item:.constant(selected), orders: orders,path:$path)
            }
            .appBackground
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(menu:MenuModel().menu, selectedItem: .constant(testMenuItem), path: .constant(NavigationPath()))
            .environment(OrderModel())
    }
}
