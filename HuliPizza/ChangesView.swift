//
//  ChangesView.swift
//  HuliPizza
//
//  Created by Jonathan Jiles on 8/23/24
//

import SwiftUI

struct ChangesView: View {
    @State private var count:Int = 0
    @State private var shape:String = ""
    var body: some View {
        VStack{
            Image(systemName: "\(count)" + shape)
                .resizable()
                .scaledToFit()
            Stepper("Count \(count)",value: $count,step: 1)
                .font(.title)
            Spacer()
        }
        .onChange(of: count) { oldValue, newValue in
            shape = (newValue % 2 == 0) ? ".circle" : ".square"
        }
        .onAppear {
            count = 42
            shape = ".circle.fill"
        }
    }
}

#Preview {
    ChangesView()
}
