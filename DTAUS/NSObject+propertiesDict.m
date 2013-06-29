//
//  NSObject+propertiesDict.m
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

#import "NSObject+propertiesDict.h"
#import <objc/runtime.h>

@implementation NSObject (propertiesDict)
- (NSDictionary *)tcPropertiesDictionary {
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
    NSMutableDictionary *propertiesDict = [NSMutableDictionary dictionaryWithCapacity:propertyCount];
    for (unsigned int i = 0; i < propertyCount; i++) {
        objc_property_t aProperty = properties[i];
        const char *propertyName = property_getName(aProperty);
        NSString *name = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        
        const char *getterName = property_copyAttributeValue(aProperty, "G");
        if (getterName == NULL) {
            getterName = propertyName;
        }
        SEL getter = NSSelectorFromString([NSString stringWithCString:getterName encoding:NSUTF8StringEncoding]);

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        propertiesDict[name] = [self performSelector:getter] ?: @"";
#pragma clang diagnostic pop
    }
    return propertiesDict;
}

@end
