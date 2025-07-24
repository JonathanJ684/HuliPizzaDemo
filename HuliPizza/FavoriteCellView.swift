//
//  FavoriteCellView.swift
//  HuliPizza
//
//  Created by Jonathan Jiles on 8/23/24
//

import SwiftUI

struct FavoriteCellView: View {
    var menuItem:MenuItem
    var body: some View {
        VStack {
           
                if let image = UIImage(named: "\(menuItem.id)_sm"){
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight:50)
                } else {
                    Image("surfboard_sm")
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight:50)
                        .padding(5)
                        
                }
            Text(menuItem.name)
                .font(.caption2)
            
        }
    }
}

#Preview {
    FavoriteCellView(menuItem:testMenuItem)
}
