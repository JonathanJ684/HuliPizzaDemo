//
//  RecieptView.swift
//  HuliPizza
//
//  Created by Jonathan Jiles on 8/23/24
//

import SwiftUI

struct ReceiptView: View {
    var orders:OrderModel
    @Binding var presentView:Bool
    var body: some View {
        VStack{
            
            HStack{
                Spacer()
                Text("Receipt")
                .surfboardTitle
            }
                .surfboardBackground
            Grid{
                GridRow{
                    Text("Item")
                        .gridColumnAlignment(.leading)
                        .gridCellAnchor(.center)
                    Text("Price")
                        .gridColumnAlignment(.trailing)
                        .gridCellAnchor(.center)
                    Text("Quantity")
                    Text("Ext Price")
                        .gridColumnAlignment(.trailing)
                        .gridCellAnchor(.center)
                   
                }
                Divider()
                ForEach(orders.orderItems){ item in
                    GridRow{
                        Text(item.item.name)
                        Text(item.item.price,format:.currency(code:"usd"))
                        Text(item.quantity,format:.number)
                        Text(item.extPrice,format:.currency(code:"usd"))
                    }
                }
                Divider()
                GridRow{
                    Text("Total")
                        .gridCellColumns(3)
                        .gridCellAnchor(.trailing)
                    Text(orders.orderTotal,format:.currency(code: "usd"))
                }
                
            }
            .background(.regularMaterial)
            Spacer()
            Button("Okay"){
                presentView = false
            }
                .appButtonStyleModifier(backgroundColor: .sky)
            
        }
       .appBackground
    }
    
}

#Preview {
    ReceiptView(orders:OrderModel(), presentView:.constant(true) )
}
