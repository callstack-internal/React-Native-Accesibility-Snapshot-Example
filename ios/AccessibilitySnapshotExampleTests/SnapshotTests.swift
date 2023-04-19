import Foundation
import XCTest
import React

@objc(SnapshotTests)
class SnapshotTests: NSObject, RCTBridgeModule {
  static func moduleName() -> String! {
    "SnapshotTests"
  }
  
  var items: [String]? = []
  
  @objc(registerName:)
  func register(name: String) -> NSNumber? {
    guard let items = items else {
      return nil
    }
    
    if items.contains(name) {
      self.items = nil
      NSException.raise(.init(rawValue: "Name already registered"),
                        format: "%@ already registered",
                        arguments: getVaList([name]))
      print("\(name) already registered")
    }
    
    self.items!.append(name)
    return NSNumber(booleanLiteral: true)
  }
}
