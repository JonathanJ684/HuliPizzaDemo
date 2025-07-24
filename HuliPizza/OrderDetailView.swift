//
//  OrderDetailView.swift
//  HuliPizza
//
//  Created by Jonathan Jiles on 8/23/24
//  Revison 1.1.0 Jonathan Jiles on 11/28/24
//  A version of `OrderItemView` to improve visuals
//  for use in the navigation chapter


import SwiftUI

struct OrderDetailView: View {
    @Binding var orderItem:OrderItem
    @Binding var presentSheet:Bool
    //
    var newOrder:Bool
    
    // these are local instances of the pizza
    // order which change the UI, but not the exisiting order.
    // they only change the orderItem after we press the Order Button
    @State private var quantity:Int = 1
    @State private var doubleIngredient:Bool = false
    @State private var pizzaCrust:PizzaCrust = .neopolitan
    @State private var name:String = ""
    @State private var comments:String = ""
    
    
    //Environment Object
    @Environment(OrderModel.self) var orders:OrderModel
    
    /// Find the extended price of the order by mutplying the quantity by the stated price of the menu item.
    var extPrice:Double{
        orderItem.item.price * Double(quantity)
    }
    
    
    /// Initializer to correctly assign wrapped values of binding variables using the `.wrapped` property of a binding variable. We do this to have new instances of the order values, which have the `@State` variables above.
    init(orderItem:Binding<OrderItem>,presentSheet:Binding<Bool>,newOrder:Bool = true){
        self._orderItem = orderItem
        self._presentSheet = presentSheet
        self.newOrder = newOrder
        
        
    }

    
    /// A function that assigns the `@State` variables to the corresponding values of the `orderItem`
    func updateOrder(){
        orderItem.quantity = quantity
        orderItem.extraIngredients = doubleIngredient
        orderItem.name = name
        orderItem.preferredCrust = pizzaCrust
        orderItem.comments = comments
    }
    
    var body: some View {
        VStack{
// Image and name banner-------------------
            HStack {
                if let image = UIImage(named: "\(orderItem.item.id)_lg"){
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .padding([.top,.bottom],5)
                        .cornerRadius(15)
                    
                } else {
                    Image("surfboard_lg")
                        .resizable()
                        .scaledToFit()
                    
                }
                Text(orderItem.item.name)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.sky)
                    .padding(.trailing)
            }
            .background(.linearGradient(colors: [.surf,.deep], startPoint: .leading, endPoint: .trailing), in:Surfboard())
// Quantitty, crust and price label--------
            HStack{
                Text(quantity,format:.number)
                Text(pizzaCrust.rawValue + " Crust")
                Text(doubleIngredient ? "double topping":"")
                Text("@")
                Text(orderItem.item.price,format:.currency(code: "USD"))
                Spacer()
                Text(extPrice,format:.currency(code: "USD"))
                    .bold()
                
            }
            .font(.headline)
            .foregroundStyle(sky)
            .fontWeight(.bold)
            // Ask who this pizza is for
            TextField("Customer Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
// Pizza Attributes-------------------
            VStack{
// Crust picker-------------------
                Picker(selection: $pizzaCrust) {
                    ForEach(PizzaCrust.allCases,id:\.self){crust in
                        Text(crust.rawValue).tag(crust)
                    }
                } label: {
                    Text("Pizza Crust" + pizzaCrust.rawValue)
                    
                }
                
                .pickerStyle(SegmentedPickerStyle())
                .foregroundColor(.black)
                .background(.ultraThickMaterial)
                
// Double the toppings?-------------------
                Toggle(isOn: $doubleIngredient){
                    Text((doubleIngredient ? "Double Toppings" : "Single Toppings"))
                }
                
//How many pizzas? -------------------
                Stepper(value: $quantity, in: 1...10 ){
                    Text("\(quantity) " + (quantity == 1 ? "pizza" : "pizzas"))
                }
            }
            .padding(5)
            .background(.regularMaterial)
            .cornerRadius(3)
            
//Comments and requests about the order-------------------
            Text("Comments and Requests").font(.headline).foregroundColor(.primary)
            TextEditor(text:$comments)
                .frame(maxHeight:200)
                .clipShape(RoundedRectangle(cornerRadius: 3))
                .shadow(radius: 1)
            Spacer()
//Order and Cancel buttons-------------------
            HStack {
            
//Order Button-------------------------
                Button(newOrder ? "Order" : "Change"){
                    updateOrder()
                    if newOrder{
                        orders.addOrder(orderItem: orderItem)
                    } else {
                        orders.updateOrder(orderItem: orderItem)
                    }
                    presentSheet = false
                }
                .appButtonStyleModifier(backgroundColor: .palm)
//                .padding()
//                .padding([.leading,.trailing])
//                .foregroundColor(.white)
//                .background(.green,in: Capsule())
//                .font(.title)
//                .padding(.trailing,20)
//                .shadow(radius:7,x:2,y:2)
//Cancel Button-------------------------
                Button("Cancel"){
                    presentSheet = false
                }
                .appButtonStyleModifier(backgroundColor: .sunset)
            }
        }
        .padding()
        .appBackground
        .onAppear{
            self.pizzaCrust = orderItem.item.crust
            self.quantity = Int(orderItem.quantity)
            self.doubleIngredient = orderItem.extraIngredients
            self.name = orderItem.name
            self.comments = orderItem.comments
        }
        .navigationBarBackButtonHidden()
//        .navigationTitle(orderItem.item.name)
//        .navigationBarTitleDisplayMode(.large)
//        .toolbar{
//            ToolbarItemGroup(placement: .navigation) {
//                HStack{
//                    Button("Cancel"){
//                        presentSheet = false
//                    }
//                    
//                    Button(newOrder ? "Order" : "Change"){
//                        updateOrder()
//                        if newOrder{
//                            orders.addOrder(orderItem: orderItem)
//                        } else {
//                            orders.updateOrder(orderItem: orderItem)
//                        }
//                        presentSheet = false
//                    }
//                }
//                .padding([.leading,.trailing],10)
//                .background(sky)
//            }
//        }
        
    }
    
}

struct OrderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetailView(
            orderItem:  .constant(OrderItem(id: 0, item: testItem2)),
            presentSheet: .constant(true)).environment(OrderModel())
    }
}
/// used instead of a `nil` for database reasons.
let noOrderItem = OrderItem(id: -1, item:noMenuItem)
let testItem2 = MenuItem(id: 1, category: .mainland, name: "test Pizza", description: "test", crust: .calzone, price: 12.00, rating: 2)
