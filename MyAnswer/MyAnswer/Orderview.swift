//
//  Orderview.swift
//  MyAnswer
//
//  Created by Son Le on 02/11/2023.
//

import SwiftUI

//https://stackoverflow.com/questions/77408082/swift-appendinterpolation-error-with-text
struct Product: Codable, Hashable, Identifiable {
    var id: Int = 0
    var quantity: Int = 0
    var price: Int = 0
}

extension Product {
    var subTotal: Double {
        Double(quantity * price)
    }
}

class Order: ObservableObject {
    
    @Published var products: [Product] = []
    @Published private(set) var productTotal: Double = 0
    @Published private(set) var productSubTotal: Double = 0
    
    func calculateTotal() {
        guard !products.isEmpty else {
            productSubTotal = 0
            return
        }
        products.forEach {
            productSubTotal += $0.subTotal
        }
    }
    
    func removeProducts() {
        products.removeAll()
        calculateTotal()
    }
    
    func append(_ product: Product) {
        products.append(product)
        calculateTotal()
    }
}

struct Orderview: View {
    @EnvironmentObject var order: Order
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Total \(order.productSubTotal)")
                
                List {
                    ForEach(order.products) { product in
                        Text("Sub total: \(product.subTotal, specifier: "%.2f")")
                    }
                }
            }
            .toolbar {
                HStack {
                    Button {
                        order.append(.init(id: Int.random(in: 10_000...1_000_000),
                                           quantity: Int.random(in: 1...10),
                                           price: Int.random(in: 10_000...1_000_000)))
                    } label: {
                        Text("Add")
                    }
                    
                    Button {
                        order.removeProducts()
                    } label: {
                        Text("Remove")
                    }
                }
            }
        }
    }
}

struct Orderview_Previews: PreviewProvider {
    static var previews: some View {
        Orderview()
            .environmentObject(Order())
    }
}
