//
//  OrderRowView.swift
//  HuliPizza
//
//  Created by Jonathan Jiles on 8/23/24
//

import SwiftUI

struct OrderRowView: View {
    @Binding var order:OrderItem
    
    @ViewBuilder var extPrice: some View{
        Text(order.extPrice, format: .currency(code: "USD"))
            .fontWeight(.semibold)
    }
    
    @ViewBuilder var PizzaNameView: some View{
        Text(order.item.name)
        Spacer()
        if order.quantity <= 1 {
            extPrice
        }
    }
    
    @ViewBuilder var extendedPriceView: some View{
        if order.quantity > 1{
            Text(order.quantity, format:.number)
            Text(" Pizzas")
            Spacer()
            extPrice
        } else {
            Text("Single Pizza")
        }
    }
    var body: some View {
        VStack {
            HStack {
                PizzaNameView
            }
            HStack(alignment:.firstTextBaseline){
                extendedPriceView
            }
        }
    }
}

struct OrderRowView_Previews: PreviewProvider {
    static var previews: some View {
        OrderRowView(order: .constant(testOrderItem))
    }
}
