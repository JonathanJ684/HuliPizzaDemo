//
//  OrderView.swift
//  HuliPizza
//
//  Created by Jonathan Jiles on 8/23/24
//

import SwiftUI

let orderBackground = LinearGradient(stops:gradientStops,startPoint:.bottomLeading,endPoint: .topTrailing)
let cellBackground = RadialGradient(colors: [sky,.red,.yellow,.green,.blue,.purple,sky], center: .bottomTrailing, startRadius: 75, endRadius: 125)
struct OrderView: View {
    @Bindable var orders:OrderModel
    @State private var presentView:Bool = false
    @State private var selected = noOrderItem
    @State private var presentReceipt = false
    var body: some View {
        VStack {
            ZStack(alignment:.top){
                
                
                List{
                    ForEach($orders.orderItems){ order in
                        //Text(order.item.name)
                        OrderRowView(order: order)
                            .listRowStyleModifier(imageID: order.item.id)
//                            .padding(4)
////                            .background(.regularMaterial,in:RoundedRectangle(cornerRadius: 10))
//                            .background(cellBackground,in:RoundedRectangle(cornerRadius: 10))
//                            .shadow(radius: 10)
//                            .padding(.bottom, 5)
//                            .padding([.leading,.trailing],7)
                           
                            .animation(.bouncy(duration:2), value: orders.orderItems.count)
                            .onTapGesture{
                                selected = order.wrappedValue
                                presentView = true
                            }
                        
//                            .sheet(isPresented:$presentView){
//                                orders.updateOrder(orderItem:selected)
//                            } content:{
//                                OrderDetailView(orderItem: $selected, presentSheet: $presentView, newOrder: false)
//                            }
                    }
                    .onDelete { offset in
                        orders.orderItems.remove(atOffsets: offset)
                    }
                }
                .navigationDestination(isPresented: $presentView, destination: {
                    OrderDetailView(orderItem: $selected, presentSheet: $presentView, newOrder: false)
                })
                .padding(.top,70)
                HStack {
                    Text("Order Pizza")
                        .font(.title)
                    Spacer()
                    
                }
                .padding()
                .background(.ultraThinMaterial)
            }
            .padding()
//            Button("Delete Order"){
//                if !orders.orderItems.isEmpty{orders.removeLast()}
//            }
//            .padding(5)
//            .background(.regularMaterial,in:Capsule())
//            .padding(7)
            Button("Receipt"){
                 presentReceipt = true
             }
             .surfboardTitle
             .appButtonStyleModifier(backgroundColor: .palm)
                 .padding()
             
            .sheet(isPresented: $presentReceipt) {
             ReceiptView(orders: orders, presentView: $presentReceipt)
            }
        }
        .background(orderBackground)
    }
}


struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView(orders: OrderModel())
    }
}
