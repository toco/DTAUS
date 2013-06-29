//
//  NSString+DIN66003.m
//
//  Created by Tobias Conradi on 06.01.13.
//
// Copyright (c) 2013 Tobias Conradi
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "NSString+DIN66003.h"

@implementation NSString (DIN66003)
- (NSString*) stringFromDIN66003 {
    return [self stringByApplingMappingDictionary:[self stringMapDIN66003]];
}
- (NSString*) stringToDIN6603 {
    return [self stringByReverseApplingMappingDictionary:[self stringMapDIN66003]];
}

- (NSString*)stringByApplingMappingDictionary:(NSDictionary*)mappingDictionary {
    NSMutableString* newString = [self mutableCopy];
    [mappingDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSParameterAssert([key isKindOfClass:[NSString class]]);
        NSParameterAssert([obj isKindOfClass:[NSString class]]);
        [newString replaceOccurrencesOfString:key withString:obj options:0 range:NSMakeRange(0, [newString length])];
    }];
    return [newString copy];
}

- (NSString*)stringByReverseApplingMappingDictionary:(NSDictionary*)mappingDictionary {
    NSMutableString* newString = [self mutableCopy];
    [mappingDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSParameterAssert([key isKindOfClass:[NSString class]]);
        NSParameterAssert([obj isKindOfClass:[NSString class]]);
        [newString replaceOccurrencesOfString:obj withString:key options:0 range:NSMakeRange(0, [newString length])];
    }];
    return [newString copy];
}

- (NSDictionary*)stringMapDIN66003 {
    return @{@"@": @"§",
             @"[": @"Ä",
             @"\\": @"Ö",
             @"]": @"Ü",
             @"{": @"ä",
             @"|": @"ö",
             @"}": @"ü",
             @"~": @"ß"
             };
}
@end
