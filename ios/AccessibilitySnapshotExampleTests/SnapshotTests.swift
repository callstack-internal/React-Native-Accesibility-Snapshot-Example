import Foundation
import XCTest
import React

@objc(SnapshotTests)
class SnapshotTests: NSObject, RCTBridgeModule {
  static func moduleName() -> String! {
    "SnapshotTests"
  }
  
  var items: [Configuration]? = []
  
  @objc(registerName:width:height:)
  func register(name: String, width: NSNumber, height: NSNumber) -> NSNumber? {
    guard let items = items else {
      return nil
    }
    
    if items.contains(where: { $0.name == name }) {
      self.items = nil
      NSException.raise(.init(rawValue: "Name already registered"),
                        format: "%@ already registered",
                        arguments: getVaList([name]))
      print("\(name) already registered")
    }
    
    self.items!.append(.init(name: name, width: width.intValue, height: height.intValue))
    return NSNumber(booleanLiteral: true)
  }
  
  struct Configuration {
    let name: String
    let width: Int
    let height: Int
  }
}
