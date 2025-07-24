//
//  SplitViewMenu.swift
//  HuliPizza
//
//  Created by Jonathan Jiles on 8/23/24
//

import SwiftUI

struct SplitViewMenu: View {
    private var menu = MenuModel().menu
    
    var body: some View {
        NavigationSplitView {
            List(MenuCategory.allCases,id:\.self){ category in
                Section(category.rawValue){
                    ForEach(menu.filter{$0.category == category}){ item in
                        NavigationLink{
                            detailView(item.name, image: "\(item.id)_lg")
                        } label:{
                            Text(item.name)
                        }
                    }
                }
            }
        } detail: {
            detailView("Huli Pizza Company", image: "")
        }

    }
    
    func detailView(_ text:String,image:String) -> some View{
            VStack{
                Text(text)
                    .surfboardBackground
                if let image = UIImage(named: image){
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .padding([.top,.bottom],5)
                        .cornerRadius(15)
                    
                } else {
                    Image("surfboard_lg")
                        .resizable()
                        .scaledToFit()
                        .rotationEffect(.degrees(180))
                }
            }
        }
}

#Preview {
    SplitViewMenu()
}
