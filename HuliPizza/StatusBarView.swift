//
//  StatusBarView.swift
//  HuliPizza
//
//  Created by Jonathan Jiles on 8/23/24
//

import SwiftUI

enum GridToggleAnimation:CaseIterable{
    case inPhase,midPhase,outPhase
    
    var opacity:Double{
        switch self{
        case .inPhase: 1.0
        case .midPhase:0.0
        case .outPhase:0.5
        }
    }
    
    var size:Double{
        switch self{
        case .inPhase: 1.0
        case .midPhase:0.5
        case .outPhase:2.0
        }
    }
}

struct StatusBarView: View {
    @Binding var showOrders:Bool
    @Binding var presentGrid:Bool
    @Environment(OrderModel.self) var orders
    
    var discountTier:Double{
        orders.orderTotal / 50.00
    }
    
    var isDiscountFulfilled:Bool{
        discountTier >= 1.0
    }
    
    var isEmptyBasket:Bool{
        orders.orderItems.isEmpty
    }
    
    var body: some View {
        HStack {
            Image(systemName: "rainbow", variableValue: discountTier)
                .symbolRenderingMode(.multicolor)
                .symbolEffect(.disappear,isActive: isEmptyBasket)
                .symbolEffect(.variableColor,isActive: isDiscountFulfilled)
            Text("\(orders.orderItems.count) orders")
            Spacer()
            Image(systemName: presentGrid ? "square.grid.3x3.square" : "list.bullet.rectangle")
                .symbolEffect(.disappear,isActive: showOrders)
//                .phaseAnimator(GridToggleAnimation.allCases,trigger:presentGrid){ content,phase in
//                    content
//                        .opacity(phase.opacity)
//                        .scaleEffect(phase.size)
//                } animation:{ phases in
//                    switch phases{
//                    case .inPhase: .bouncy
//                    case .midPhase:.linear
//                    case .outPhase:.easeOut
//                    }
//                }
//                .onTapGesture {
//                    presentGrid.toggle()
//                }
//            Button{
//                showOrders.toggle()
//            } label:{
//                Image(systemName: showOrders ? "cart" : "menucard")
//                    .contentTransition(.symbolEffect(.replace))
//            }
//            .phaseAnimator(GridToggleAnimation.allCases,trigger:showOrders){ content,phase in
//                content
//                    .opacity(phase.opacity)
//                    .scaleEffect(phase.size)
//            } animation:{ phases in
//                switch phases{
//                case .inPhase: .bouncy
//                case .midPhase:.linear
//                case .outPhase:.easeOut
//                }
//            }
            Spacer()
            Label{
                Text(orders.orderTotal,format: .currency(code: "USD"))
            }icon:{
                //Image(systemName: orders.orderItems.isEmpty ? "cart" : "cart.circle.fill")
                Image(systemName:"cart")
                    .symbolVariant(isEmptyBasket ? .none : .fill)
                    .symbolEffect(.bounce, value: isEmptyBasket)
                    .symbolEffect(.scale.up,isActive: isDiscountFulfilled)
            }
        
        }
        .foregroundStyle(.white)
        .font(.title2)
    }
}

struct StatusBarView_Previews: PreviewProvider {
    static var previews: some View {
        StatusBarView(showOrders: .constant(false), presentGrid: .constant(false))
            .environment(OrderModel())
    }
}
