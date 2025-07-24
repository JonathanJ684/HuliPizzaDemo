//
//  MenuItemView.swift
//  HuliPizza
//
//  Created by Jonathan Jiles on 8/23/24
//

import SwiftUI
let radialGradient = RadialGradient(colors: [surf,sky], center: .bottom, startRadius: 75, endRadius: 300)
let gradientStops:[Gradient.Stop] = [
    Gradient.Stop(color: surf, location: 0.0),
    Gradient.Stop(color: sky, location: 0.33),
    Gradient.Stop(color: surf, location: 0.95),
    Gradient.Stop(color: sky, location: 1.0)
    
]

let linearStopGradient = LinearGradient(stops: gradientStops, startPoint: .top, endPoint: .bottom)

struct MenuItemView: View {
    @State private var addedItem:Bool = false
    @State private var presentView:Bool = false
    @State private var orderItem:OrderItem = noOrderItem
    @State private var suggestedItem:MenuItem = MenuModel().menu.randomElement() ?? noMenuItem
    @Binding var item:MenuItem
    @Bindable var orders:OrderModel
    @Binding var path:NavigationPath
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    var allRegular:Bool{
        verticalSizeClass == .regular &&
        horizontalSizeClass == .regular
    }
    var isPortrait:Bool{
        verticalSizeClass == .regular &&
        horizontalSizeClass == .compact
    }
    
    var foodImageView: some View{
        NavigationLink{
            ItemImageView(item:item)
        } label:{
            if let image = UIImage(named: "\(item.id)_lg"){
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .padding([.top,.bottom],5)
                //                    .clipShape(RoundedRectangle(cornerRadius:10))
                    .cornerRadius(15)
                
            } else {
                Image("surfboard_lg")
                    .resizable()
                    .scaledToFit()
                    .rotationEffect(.degrees(180))
            }
        }
        
        
    }
    var descriptionView: some View{
        ScrollView {
            Text(item.description)
                .font(.custom("Georgia",size: 18,relativeTo: .body))
        }
    }
    var suggestedItemView: some View {
        NavigationLink(value:suggestedItem){
            VStack{
                Text("You Might Also Like").textCase(.uppercase).font(.caption)
                MenuRowView(item:suggestedItem)
                    .foregroundStyle(.primary)
            }
            .padding()
            .background(.regularMaterial)
        }
        .navigationDestination(for: MenuItem.self) { _ in
            MenuItemView(item: $suggestedItem, orders: orders, path: $path)
        }
    }
    
    var body: some View {
        VStack {
            if isPortrait{
                VStack{
                    HStack{
                        foodImageView
                        Text(item.name)
                            .surfboardTitle
                    }
                    .surfboardBackground
                    descriptionView
                    suggestedItemView
                }
            } else {
                HStack(alignment:.top){
                   foodImageView
                    descriptionView
                    
                }
                if allRegular{
                    suggestedItemView
                }
            }
            
            HStack{
                Button{
                    orderItem.item = item
                    presentView = true
                } label:{
                    Spacer()
                    Text(item.price,format:.currency(code: "USD")).bold()
                        .font(path.count <= 1 ? .title : .title3)
                    Image(systemName: addedItem ? "cart.fill.badge.plus" : "cart.badge.plus")
                    Spacer()
                }
                .sheet(isPresented: $presentView) {
                    path = NavigationPath()
                }content: {
                    OrderFormView(orderItem: $orderItem, presentSheet: $presentView)
                }
                
                .disabled(item.id < 0 )
                .appButtonStyleModifier(backgroundColor: .palm)
                
                CustomBarView(path: $path)
            }
        }
        .navigationBarBackButtonHidden()
        .toolbarVisibility(.hidden, for: .tabBar)
        .appBackground
    }
}

struct MenuItemView_Previews: PreviewProvider {
    static var previews: some View {
        MenuItemView(item: .constant(testMenuItem), orders: OrderModel(), path: .constant(NavigationPath()))
    }
}
