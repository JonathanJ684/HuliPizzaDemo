//
//  SFSymbolPlay.swift
//  SFSymbolPlayBase
//
//  Created by Jonathan Jiles on 8/23/24
//

import SwiftUI

struct SFSymbolPlayView: View {
    @State var isFilled:Bool = false
    @State var isAnimating:Bool = false
    @State var isCircle:Bool = false
    @State var isSlash:Bool = false
    @State var scale:Double = 1.0
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName:"square")
                Spacer()
                Text("Symbol Play")
                    .font(.title).bold()
                Spacer()
                Image(systemName:"square")
            }
            .padding([.leading,.trailing])
            .background(.thickMaterial,in:Capsule())
//Rainbow
            Image(systemName: "rainbow",variableValue: scale)
                .resizable()
                .scaledToFit()
                .symbolRenderingMode(.multicolor)
                .symbolEffect(.variableColor.iterative, isActive: isAnimating)
            HStack{
// Pencil
                Image(systemName: "pencil")
                    .resizable()
                    .scaledToFit()
                    .symbolVariant(isSlash ? .slash : .none)
                    .symbolVariant(isCircle ? .circle : .none)
                    .symbolVariant(isFilled ? .fill : .none)
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.primary)
                    .contentTransition(.symbolEffect(.replace))
                Spacer()
// Folder with badge
                Image(systemName: isAnimating ? "folder.badge.plus" :"folder.badge.minus" )
                    .resizable()
                    .scaledToFit()
                    .symbolRenderingMode(.multicolor)
                    .foregroundStyle(.secondary)
                    //.symbolEffect(.rotate, value: isSlash)
                    .contentTransition(.symbolEffect(.replace))
            }
            .frame(height:100)
            Spacer()
// 3 Person
            HStack{
                Image(systemName: "person" + (isCircle ? ".2":".3"),variableValue: scale)
                    .resizable()
                    .scaledToFit()
                    .symbolVariant(isFilled ? .fill : .none)
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.indigo)
                    .symbolEffect(.breathe, isActive: isAnimating)
                    .contentTransition(.symbolEffect(.replace))
                Spacer()
//  3 person sequential
                Image(systemName: "person.3.sequence", variableValue: scale)
                    .resizable()
                    .scaledToFit()
                    .symbolVariant(.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.green, .indigo,.orange)
                    .symbolEffect(.variableColor, isActive: isAnimating)
            }
            .frame(height:100)
            Spacer()
            VStack(alignment:.leading){
                HStack{
                    Text("Scale")
                    Text(scale,format: .number)
                }
                Slider(value:$scale,in: 0...1)
                    .padding()
                HStack{
                    Button{
                        isFilled.toggle()
                    } label:{
// Fill
                        Image(systemName: "circle" + (isFilled ? ".fill" : ""))
                            .symbolEffect(.bounce, value: isFilled)
                           
                    }
                    Spacer()
                    Button{
                        isCircle.toggle()
                    } label:{
// Circle
                        Image(systemName: "circle" + (isCircle ? "" : ".dotted"))
                            .symbolEffect(.bounce, value: isCircle)
                    }
                    Spacer()
                    Button{
                        isSlash.toggle()
                    } label:{
// Slash
                        Image(systemName: "slash.circle" + (isSlash ? ".fill" : ""))
                            .symbolEffect(.rotate, value: isSlash)
                            .symbolEffect(.scale.down,isActive: isCircle)
                    }
                    Spacer()
                    Button{
                        isAnimating.toggle()
                    } label:{
// Animating
                        Image(systemName: "play.rectangle" + (isAnimating ? ".fill" : ""))
                            .symbolEffect(.breathe, isActive: isAnimating)
                    }
                    
                }
                .font(.largeTitle)
                .imageScale(.large)
                .foregroundStyle(.primary)
            }
            .padding()
            .background(.regularMaterial)
            Spacer()
        }
        .onChange(of:scale){
            isAnimating = false
        }
        .padding()
        
    }
}

#Preview {
    SFSymbolPlayView()
}
