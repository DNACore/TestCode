//
//  FilteredWebCache.m
//  TestCode
//
//  Created by Encoder on 15/12/2.
//  Copyright © 2015年 Encoder. All rights reserved.
//

#import "FilteredWebCache.h"

@implementation FilteredWebCache
- (NSCachedURLResponse*)cachedResponseForRequest:(NSURLRequest*)request
{
    NSString *url = [request URL].absoluteString;
    NSLog(@"---------%lu--%@",(unsigned long)[self currentDiskUsage],url);
//    if (blockURL) {
//        NSURLResponse *response =
//        [[NSURLResponse alloc] initWithURL:url
//                                  MIMEType:@"text/plain"
//                     expectedContentLength:1
//                          textEncodingName:nil];
//        NSCachedURLResponse *cachedResponse =
//        [[NSCachedURLResponse alloc] initWithResponse:response
//                                                 data:[NSData dataWithBytes:" " length:1]];
//        [super storeCachedResponse:cachedResponse forRequest:request];
//        [cachedResponse release];
//        [response release];
//    }
    return [super cachedResponseForRequest:request];
}

- (void)storeCachedResponse:(NSCachedURLResponse *)cachedResponse forRequest:(NSURLRequest *)request{
    [super storeCachedResponse:cachedResponse forRequest:request];
}
@end
