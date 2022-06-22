//
//  SourceLoader.m
//  RichTap-Test
//
//  Created by Arthas on 2022/6/15.
//

#import "SourceLoader.h"

@implementation SourceLoader
+ (instancetype)sharedLoader {
    static SourceLoader *sourceLoader = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (nil == sourceLoader) {
            sourceLoader = [[SourceLoader alloc] init];
        }
    });
    return sourceLoader;
}

- (NSString *)pathForHeFile:(NSString *)fileName {
    return [[NSBundle mainBundle] pathForResource:fileName ofType:@"he"];
}

- (NSString *)pathForWavFile:(NSString *)audioFileName {
    return [[NSBundle mainBundle] pathForResource:audioFileName ofType:@"wav"];
}
@end
