//: Playground - noun: a place where people can play

import UIKit

// Using Object composition to avoid the headaches caused by subclassing.
// Imagine a coffee shop with a subclass of Coffee to represent 
// Every permutation of combinations.
// ** Classes should be open for extension but closed for modification **

enum Size {
  case Small, Medium, Large

  func cost() -> Double {
    switch self {
    case .Small:
      return 0.99
    case .Medium:
      return 1.99
    case .Large:
      return 2.99
    }
  }
}
protocol Beverage {
  var description: String { get }
  var size: Size { get }
  func cost() -> Double
}

// Could easily add a size without updating all the 
// concrete beverages
extension Beverage {
  var size: Size {
    return .Small
  }
}

protocol Condiment: Beverage {
  init(beverage: Beverage)
}

// Concrete Beverages
class HouseBlend: Beverage {
  var description: String {
    return "HouseBlend"
  }

  func cost() -> Double {
    return 2.99 + size.cost()
  }
}

class DarkRoast: Beverage {
  var description: String {
    return "DarkRoast"
  }

  func cost() -> Double {
    return 2.99 + size.cost()
  }
}

class Tea: Beverage {
  var description: String {
    return "Tea"
  }

  func cost() -> Double {
    return 0.99 + size.cost()
  }
}

// Concrete Condiments
class Sugar: Condiment {
  private let beverage: Beverage

  required init(beverage: Beverage) {
    self.beverage = beverage
  }

  var description: String {
    return "\(beverage.description) with Sugar"
  }

  func cost() -> Double {
    return 0.75 + beverage.cost()
  }
}

class Cream: Condiment {
  private let beverage: Beverage

  required init(beverage: Beverage) {
    self.beverage = beverage
  }

  var description: String {
    return "\(beverage.description) with Cream"
  }

  func cost() -> Double {
    return 1.0 + beverage.cost()
  }
}

class Milk: Condiment {
  private let beverage: Beverage

  required init(beverage: Beverage) {
    self.beverage = beverage
  }

  var description: String {
    return "\(beverage.description) with Milk"
  }

  func cost() -> Double {
    return 0.5 + beverage.cost()
  }
}

class WhipCream: Condiment {
  private let beverage: Beverage

  required init(beverage: Beverage) {
    self.beverage = beverage
  }

  var description: String {
    return "\(beverage.description) with WhipCream"
  }

  func cost() -> Double {
    return 0.25 + beverage.cost()
  }
}

// Decorator Pattern

// HouseBlend with Milk and Sugar
var houseBlend: Beverage = HouseBlend()
houseBlend = Milk(beverage: houseBlend)
houseBlend = Sugar(beverage: houseBlend)

// Cost should be 2.99 + 0.5 + 0.75 + Size Small = 5.23
// Should read as HouseBlend Milk Sugar
print(houseBlend.cost())
print(houseBlend.description)

// Tea with Sugar
var tea: Beverage = Tea()
tea = Sugar(beverage: tea)
print(tea.cost())
print(tea.description)

// DarkRoast with double Milk
var darkRoast: Beverage = DarkRoast()
darkRoast = Milk(beverage: darkRoast)
darkRoast = Milk(beverage: darkRoast)
print(darkRoast.cost())
print(darkRoast.description)
