//
//  ContentView.swift
//  HuliPizza
//
//  Created by Jonathan Jiles on 8/23/24
//

import SwiftUI

let sky = Color.sky
let surf = Color.surf

struct ContentView: View {
    var menu:[MenuItem]
    @State private var orders:OrderModel = OrderModel()
    @State private var showOrders:Bool = false
    @State private var selectedItem:MenuItem = noMenuItem
    @State private var presentGrid:Bool = false
    @State private var path:NavigationPath = NavigationPath()
    
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    var body: some View {
        VStack {
            if verticalSizeClass == .regular{
                HeaderView()
                    .shadow(radius: 5)
                    .environment(\.colorScheme,.light)
                    .frame(maxHeight:100)
            } else {
                HStack{
                    Spacer()
                    Text("Huli Pizza Company")
                        .foregroundStyle(.sky)
                        .background(.surf)
                }
            }
            StatusBarView(showOrders: $showOrders, presentGrid: $presentGrid)
                .statusBarStyle
            TabView{
                
                Tab("Menu",systemImage:"menucard"){
                    NavigationStack(path:$path){
                        
                            
                        if presentGrid{
                            MenuGridView(menu: menu, selectedItem: $selectedItem)
                        } else{
                            MenuView(menu:menu, selectedItem: $selectedItem,path:$path)
                        }
                    }
                }
                
                Tab("Orders",systemImage:"cart"){
                    NavigationStack(path:$path){
                        OrderView(orders: orders)
                            .cornerRadius(10)
                    }
                }
                .badge(orders.orderCount)
                
            }
            //.tabViewStyle(.page)
            Spacer()
        }
        .padding()
        .appBackground
        .environment(orders)
        .onAppear {
            presentGrid = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(menu:MenuModel().menu)
            
    }
}

