#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(SnapshotTests, NSObject)

RCT_EXTERN__BLOCKING_SYNCHRONOUS_METHOD(registerName:(NSString *)name width:(nonnull NSNumber *)width height:(nonnull NSNumber *)height)

@end