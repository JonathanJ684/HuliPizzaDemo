//
//  CustomBarView.swift
//  HuliPizza
//
//  Created by Jonathan Jiles on 8/23/24
//

import SwiftUI

struct CustomBarView: View {
    @Binding var path:NavigationPath
    @ViewBuilder var  backButton: some View{
        Button{
            if !path.isEmpty{
                path.removeLast()
            }
        } label:{
            Image(systemName: "chevron.backward")
        }
        .appButtonStyleModifier(backgroundColor: .sky)
    }
    @ViewBuilder var  homeButton: some View{
        Button{
            path = NavigationPath()
        } label:{
            Image(systemName: "house.fill")
        }
        .appButtonStyleModifier(backgroundColor: .sky)
    }
    
    @ViewBuilder var level: some View{
        if path.count > 1{
            Text(path.count,format:.number)
                .font(.headline)
                .padding(7)
                .background(.sunset, in: Capsule())
                .foregroundStyle(.sky)
                .onTapGesture{path.removeLast()}
            
        }
    }
    
    var body: some View {
        homeButton
        backButton
        level
    }
}

#Preview {
    CustomBarView(path:.constant(NavigationPath()))
}
