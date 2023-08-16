import Foundation

public protocol Shape {
    func draw() -> String
}

struct Triangle: Shape {
    let size: Int
    
    func draw() -> String {
        var result: [String] = []
        for length in 1...size {
            result.append(String(repeating: "*", count: length))
        }
        return result.joined(separator: "\n")
    }
}

struct FlippedShape<T: Shape>: Shape {
    let shape: T
    
    func draw() -> String {
        if shape is Square {
            return shape.draw()
        }
        let lines = shape.draw().split(separator: "\n")
        return lines.reversed().joined(separator: "\n")
    }
}

struct JoinedShape<T: Shape, U: Shape>: Shape {
    let top: T
    let bottom: U
    
    func draw() -> String {
        return top.draw() + "\n" + bottom.draw()
    }
}

struct Square: Shape {
    let size: Int
    
    func draw() -> String {
        let line = String(repeating: "*", count: size)
        let result = Array<String>(repeating: line, count: size)
        return result.joined(separator: "\n")
    }
}

struct VerticalShapes: Shape {
    var shapes: [Shape]
    
    func draw() -> String {
        shapes.map { $0.draw() }.joined(separator: "\n")
    }
}

func makeTrapezoid() -> some Shape {
    let top = Triangle(size: 2)
    let middle = Square(size: 2)
    let bottom = FlippedShape(shape: top)
    let trapezoid = JoinedShape(top: top, bottom: JoinedShape(top: middle, bottom: bottom))
    return trapezoid
}
 
///Return specific type which confirm `Shape`
func flip<T: Shape>(_ shape: T) -> some Shape {
//    Invalid if its any `Shape`
//    if shape is Square {
//        return shape
//    }
    return FlippedShape(shape: shape)
}

///Return any type which conform `Shape`
func protoFlip<T: Shape>(_ shape: T) -> Shape {
//    Valid if its any type conform `Shape`
//    if shape is Square {
//        return shape
//    }
    return FlippedShape(shape: shape)
}

func repeat2<T: Shape>(shape: T, count: Int) -> some Collection {
    Array<T>(repeating: shape, count: count)
}

protocol Container {
    associatedtype Item
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

extension Array: Container { }

/*
func makeProtocolContainer<T>(item: T) -> Container {
    return [item]
}

func makeProtocolContainer<T, C: Container>(item: T) -> C {
    return item
}
*/

func makeOpaqueContainer<T>(item: T) -> some Container {
    return [item]
}

let opaqueContainer = makeOpaqueContainer(item: 10)
let ten = opaqueContainer[0]
print(type(of: ten))
