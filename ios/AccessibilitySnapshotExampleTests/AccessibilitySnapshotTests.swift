import React
import AccessibilitySnapshot
import SnapshotTesting
import XCTest

class AccessibilitySnapshotTests : XCTestCase {
  let bridge = RCTBridge(bundleURL: ProcessInfo.processInfo.environment["USE_LOCAL_BUNDLE"] == nil
                         ? RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index")
                         : Bundle.main.url(forResource: "main", withExtension: "jsbundle")!,
                         moduleProvider: nil)!
  
  func testAccessibilitySnapshot() {
    let expectation = expectation(description: "Wait for content to appear")
    let observer = Observer(expectation)
    let profileView = RCTRootView(frame: .init(x: 0, y: 0, width: 300, height: 700),
                                  bridge: bridge,
                                  moduleName: "ProfileTest",
                                  initialProperties: nil)
    NotificationCenter.default.addObserver(observer,
                                           selector: #selector(observer.handler),
                                           name: NSNotification.Name("RCTContentDidAppearNotification"),
                                           object: profileView)
    defer {
      NotificationCenter.default.removeObserver(observer)
    }
    
    _ = XCTWaiter.wait(for: [expectation], timeout: 5.0)
    
    assertSnapshot(matching: profileView, as: .accessibilityImage)
  }
}

class Observer {
  let expectation: XCTestExpectation
  
  init(_ expectation: XCTestExpectation) {
    self.expectation = expectation
  }
  
  @objc func handler(_ notification: NSNotification) {
    expectation.fulfill()
  }
}
