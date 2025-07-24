//
//  ItemImageView.swift
//  HuliPizza
//
//  Created by Jonathan Jiles on 8/23/24
//

import SwiftUI

struct ItemImageView: View {
    var item:MenuItem = testMenuItem
    var body: some View {
        VStack{
            Text(item.name)
                .font(.title).bold()
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
            Spacer()
        }
    }
}

#Preview {
    ItemImageView()
}
