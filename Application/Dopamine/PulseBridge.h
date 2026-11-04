#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PulseBridge : NSObject

+ (int)initializeJailbreak;
+ (int)prepareRootfs;
+ (int)runExploit;
+ (NSString *)getStatus;

@end

NS_ASSUME_NONNULL_END
