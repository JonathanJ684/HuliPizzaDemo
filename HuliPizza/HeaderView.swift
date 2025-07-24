//
//  HeaderView.swift
//  HuliPizza
//
//  Created by Jonathan Jiles on 8/23/24
//

import SwiftUI
struct HeaderView: View {
    @Environment(OrderModel.self) var orders
    @Environment(\.verticalSizeClass) var vSizeClass:UserInterfaceSizeClass?
    var body: some View {
        VStack {
            if (vSizeClass ?? .regular) != .compact{
                ZStack(alignment:.bottomTrailing) {
                    Image("surfBanner")
                        .resizable()
                        .scaledToFit()
                    //                .scaledToFill()
                        .ignoresSafeArea()
                    Text("Huli Pizza Company")
                        .font(.custom("Georgia", size: 30, relativeTo: .title))
                    //                .foregroundColor(.sky)
                        .foregroundStyle(.regularMaterial)
                        .fontWeight(.semibold)
                }
            } else {
                HStack(alignment:.bottom){
                    Image("surfBanner")
                        .resizable()
                        .scaledToFit()
                    Text("Huli Pizza Company")
                        .font(.custom("Georgia", size: 30, relativeTo: .title))
                        .foregroundColor(.surf)
                        .fontWeight(.heavy)
                }
            }
            
        }
        .background(.ultraThinMaterial)
    }
}


struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView().environment(OrderModel())
    }
}
