//
//  MenuRowView.swift
//  HuliPizza
//
//  Created by Jonathan Jiles on 8/23/24
//

import SwiftUI

struct MenuRowView: View {
    var item:MenuItem
    var ratingsView:RatingsView{RatingsView(rating:item.rating)}
    @ViewBuilder var namePriceView: some View{
        Text(item.name)
        Spacer()
        Text(item.price,format: .currency(code: "USD"))
    }
    var body: some View {
        HStack(alignment:.top,spacing:15) {
//            if let image = UIImage(named: "\(item.id)_sm"){
//                Image(uiImage: image)
//                    .clipShape(Circle())
//                    .padding(.trailing, -25)
//                    .padding(.leading,-15)
//            } else {
//                Image("surfboard_sm")
//            }
            VStack(alignment:.leading) {
                HStack {
                    namePriceView
                }
                ratingsView
            }
            Spacer()
        }
    }
}

struct MenuRowView_Previews: PreviewProvider {
    static var previews: some View {
        MenuRowView(item: testMenuItem)
    }
}
