import React
import AccessibilitySnapshot
import SnapshotTesting
import XCTest

class AccessibilitySnapshotTests : XCTestCase {
  func testAccessibilitySnapshot() throws {
    let bridgeDelegate = BridgeDelegate()
    
    let expectationForJavaScriptDidLoadNotification = expectation(description: "Wait for JavaScript to load")
    let observerForJavaScriptDidLoadNotification = Observer(expectationForJavaScriptDidLoadNotification)
    let bridge = RCTBridge(delegate: bridgeDelegate, launchOptions: nil)!
    NotificationCenter.default.addObserver(observerForJavaScriptDidLoadNotification,
                                           selector: #selector(observerForJavaScriptDidLoadNotification.handler),
                                           name: NSNotification.Name("RCTJavaScriptDidLoadNotification"),
                                           object: bridge)
    defer { NotificationCenter.default.removeObserver(observerForJavaScriptDidLoadNotification) }
    
    _ = XCTWaiter.wait(for: [expectationForJavaScriptDidLoadNotification], timeout: 5.0)
    
    let items = try XCTUnwrap(bridgeDelegate.snapshotTests.items, "Check logs if the same name was already registered")
        
    XCTAssertFalse(items.isEmpty)
    
    for item in items {
      let expectation = expectation(description: "Wait for content to appear")
      let observer = Observer(expectation)
      let profileView = RCTRootView(frame: .init(x: 0, y: 0, width: 300, height: 700),
                                    bridge: bridge,
                                    moduleName: item,
                                    initialProperties: nil)
      NotificationCenter.default.addObserver(observer,
                                             selector: #selector(observer.handler),
                                             name: NSNotification.Name("RCTContentDidAppearNotification"),
                                             object: profileView)
      defer { NotificationCenter.default.removeObserver(observer) }
      
      _ = XCTWaiter.wait(for: [expectation], timeout: 5.0)
      
      assertSnapshot(matching: profileView, as: .accessibilityImage(perceptualPrecision: 0.995), named: item, testName: "accessibility")
    }
  }
  
  private class Observer {
    let expectation: XCTestExpectation
    
    init(_ expectation: XCTestExpectation) {
      self.expectation = expectation
    }
    
    @objc func handler(_ notification: NSNotification) {
      expectation.fulfill()
    }
  }

  private class BridgeDelegate: NSObject, RCTBridgeDelegate {
    public let snapshotTests = SnapshotTests()
    
    func sourceURL(for bridge: RCTBridge!) -> URL! {
      ProcessInfo.processInfo.environment["USE_LOCAL_BUNDLE"] == nil
        ? RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index")
        : Bundle.main.url(forResource: "main", withExtension: "jsbundle")!
    }
    
    func extraModules(for bridge: RCTBridge!) -> [RCTBridgeModule]! {
      [snapshotTests]
    }
  }
}
