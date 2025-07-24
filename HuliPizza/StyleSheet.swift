//
//  StyleSheet.swift
//  HuliPizza
//
//  Created by Jonathan Jiles on 8/23/24
//

import SwiftUI

extension ShapeStyle where Self == Color{
    static var sky:Color{
        Color(red: 0.78, green: 0.937, blue: 1.0)
    }
    static var surf:Color{
    Color(red:0.37,green:0.527,blue:0.75)
    }
    static var deep:Color{
    Color(red:0.125,green:0.227,blue:0.376)
    }
    static var sunset:Color{
    Color(red:0.90,green:0.369,blue:0.102)
    }
    static var palm:Color{
    Color(red:0.357,green:0.637,blue:0.239)
    } 
}

struct AppBackground:ViewModifier{
    func body(content:Content) -> some View {
        content
            .background(LinearGradient(colors: [.sky,.white], startPoint: .top, endPoint: .bottom))
    }
}

struct StatusBarStyle:ViewModifier{
    func body(content:Content) -> some View {
        content
            .foregroundStyle(.sky)
            .font(.title2)
            .padding(3)
            .background(.deep,in:RoundedRectangle(cornerRadius: 3))
    }
}

struct AppButtonStyleModifier:ViewModifier {
    var backgroundColor:Color
    
    var foregroundColor:Color{
        switch backgroundColor{
        case .sky,.white,.clear :return .deep
        default : return .sky
        }
    }
    func body(content:Content) -> some View {
        content
            .font(.title).bold()
            .padding([.leading,.trailing],20)
            .padding([.top,.bottom],5)
            .background(backgroundColor)
            .foregroundStyle(foregroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        
    }
}

struct Surfboard: Shape{
    func path(in rect:CGRect) -> Path{
        var radius:Double{rect.maxY - rect.midY}
        var path = Path()
        path.move(to:CGPoint(x:rect.minX,y:rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - radius, y: rect.minY))
        path.addArc(center: CGPoint(x: rect.maxX - radius, y: rect.midY), radius: radius, startAngle: .degrees(-90), endAngle: .degrees(90), clockwise: false)
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        
        
        
        return path
    }
}

struct SurfboardBackground:ViewModifier{
    func body(content:Content) -> some View{
            content
                .padding()
                .foregroundStyle(.sky)
                .background(.deep, in:Surfboard())
    }
}

struct SurfboardTitle:ViewModifier{
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    func body(content:Content) -> some View{
        HStack{
            Spacer()
            content
                .font(
                    verticalSizeClass == .regular &&
                    horizontalSizeClass == .regular
                    ? .largeTitle : .title
                )
        }
    }
}


struct ListRowStyleModifier:ViewModifier{
    var imageID:Int
    
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    func body(content:Content) -> some View{
        ZStack{
            Surfboard()
                .stroke(Color.surf)
                .fill(Color.clear)
            HStack{
                if let image = UIImage(named: "\(imageID)_sm"){
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: verticalSizeClass == .compact ? 40: (horizontalSizeClass == .regular  ? 125 : 70))
                } else {
                    Image("surfboard_sm")
                        .resizable()
                        .scaledToFit()
                        .frame(height: verticalSizeClass == .compact ? 40: (horizontalSizeClass == .regular  ? 125 : 70))
                }
                content
                    .font(verticalSizeClass == .regular && horizontalSizeClass == .regular ? .title : .body)
                    .padding([.top,.bottom],4)
                    .padding([.leading,.trailing],12)
                    .background(.clear)
                    .foregroundStyle(.primary)
            }
        }
    }
}

extension View{
    var appBackground:some View{
        self.modifier(AppBackground())
    }
    
    var statusBarStyle:some View{
        self.modifier(StatusBarStyle())
    }
    
    var surfboardBackground:some View{
        self.modifier(SurfboardBackground())
        }
    var surfboardTitle:some View{
        self.modifier(SurfboardTitle())
        }
    
    func appButtonStyleModifier(backgroundColor:Color) -> some View{
        self.modifier(AppButtonStyleModifier(backgroundColor: backgroundColor))
    }
    
    func listRowStyleModifier(imageID:Int) -> some View{
        self.modifier(ListRowStyleModifier(imageID: imageID))
    }
}
