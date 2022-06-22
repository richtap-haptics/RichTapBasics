//
//  SourceLoader.h
//  RichTap-Test
//
//  Created by Arthas on 2022/6/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SourceLoader : NSObject
+ (instancetype)sharedLoader;
- (NSString *)pathForHeFile:(NSString *)fileName;
- (NSString *)pathForWavFile:(NSString *)audioFileName;
@end

NS_ASSUME_NONNULL_END
