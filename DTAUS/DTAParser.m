//
//  DTAParser.m
//
//  Created by Tobias Conradi on 30.12.12.
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

#import "DTAParser.h"
#import "DTAData.h"
#import "DTABuchung.h"
#import "NSString+DIN66003.h"


@interface DTAParser ()
@property (nonatomic, strong) DTAData *dtaData;
@property (nonatomic, strong) DTABuchung *currentBuchung;
@property (nonatomic, assign) BOOL scannedA;
@property (nonatomic, assign) BOOL scannedC;
@property (nonatomic, assign) BOOL scannedE;
@end

typedef NS_ENUM(NSInteger, DTASatzType) {
    DTASatzTypeUnknown = -1,
    DTASatzTypeA = 1,
    DTASatzTypeC = 2,
    DTASatzTypeE = 3
};

@implementation DTAParser
+ (DTAData *)parseData:(NSData *)dataToParse {
    DTAParser *aParser = [self new];
    return [aParser parseData:dataToParse];
}
+ (DTAData *)parseString:(NSString *)dtaString {
    DTAParser *aParser = [self new];
    if ([aParser parseDTAString:dtaString])
        return aParser.dtaData;
    else
        return nil;
    
}
- (DTAData*)parseData:(NSData*)dataToParse {
    self.dtaData = [DTAData new];
    NSString *aDTAString =[[NSString alloc] initWithData:dataToParse encoding:NSASCIIStringEncoding];
    
    BOOL success = [self parseDTAString:aDTAString];
    if (success)
        return self.dtaData;
    else
        return nil;
}

- (BOOL) parseDTAString:(NSString *)aDTAString {
    aDTAString = [aDTAString stringFromDIN66003];
    while ([aDTAString length]) {
        DTASatzType currenSatzType = [self satzTypeForSatz:aDTAString];
        switch (currenSatzType) {
            case DTASatzTypeA:
                aDTAString = [self parseSatzA:aDTAString];
                self.scannedA = YES;
                break;
            case DTASatzTypeC:
                aDTAString = [self parseSatzC:aDTAString];
                self.scannedC = YES;
                break;
            case DTASatzTypeE:
                aDTAString = [self parseSatzE:aDTAString];
                self.scannedE = YES;
                break;
            case DTASatzTypeUnknown:
                return NO;
            default:
                return NO;
        }
    }
    return self.scannedA && self.scannedC && self.scannedE;
}

/**
 * Parses the A Satz and returns the rest of the string
 */
- (NSString*)parseSatzA:(NSString*)satzAndRest {
    NSParameterAssert(satzAndRest && [self satzTypeForSatz:satzAndRest]==DTASatzTypeA);
    if ([satzAndRest length]<128) {
        NSLog(@"%s not long enough for A section: %@",__PRETTY_FUNCTION__,satzAndRest);
        return nil;
    }
    NSString *lengthString = [satzAndRest substringWithRange:NSMakeRange(0, 4)];
    NSInteger lengthInt = [lengthString integerValue];
    NSAssert1(lengthInt==128, @"length field should contain 0128, but it contains: %@",lengthString);
    
    self.dtaData.art = [satzAndRest substringWithRange:NSMakeRange(5, 2)];
    self.dtaData.auftraggeberBankleitzahl = [satzAndRest substringWithRange:NSMakeRange(7, 8)];
    // NSMakeRange(15,8) CST
    
    self.dtaData.auftraggeberName = [satzAndRest substringWithRange:NSMakeRange(23, 27)];
    self.dtaData.dateiDatum = [satzAndRest substringWithRange:NSMakeRange(50, 6)];
    // NSMakeRange(56,4) CST
    
    self.dtaData.auftraggeberKonto = [satzAndRest substringWithRange:NSMakeRange(60, 10)];
    self.dtaData.referenz = [satzAndRest substringWithRange:NSMakeRange(70, 10)];
    
    self.dtaData.ausfuerungsDatum = [satzAndRest substringWithRange:NSMakeRange(95, 8)];
    self.dtaData.waehrung = [satzAndRest substringWithRange:NSMakeRange(127, 1)];
    
    return [satzAndRest substringFromIndex:lengthInt];
}
/**
 * Parses the C Satz and returns the rest of the string
 */
- (NSString*)parseSatzC:(NSString*)satzAndRest {
    NSParameterAssert(satzAndRest && [self satzTypeForSatz:satzAndRest]==DTASatzTypeC);
    if ([satzAndRest length]<128) {
        NSLog(@"%s not long enough for C section: %@",__PRETTY_FUNCTION__,satzAndRest);
        return nil;
    }
    NSAssert1(([satzAndRest length]>=256), @"Min Satz string lenght should be 256 real length is: %ld",[satzAndRest length]);
    DTABuchung *buchung = [DTABuchung new];
    self.currentBuchung = buchung;
    [self.dtaData addBuchung:buchung];
    buchung.ersteBankBankleitzahl = [satzAndRest substringWithRange:NSMakeRange(5,8)];
    
    buchung.kundenBankleitzahl = [satzAndRest substringWithRange:NSMakeRange(13, 8)];
    buchung.kundenKontonummer = [satzAndRest substringWithRange:NSMakeRange(21, 10)];
    
    buchung.interneKundennummer = [satzAndRest substringWithRange:NSMakeRange(31, 13)];
    buchung.buchungsSchluessel = [satzAndRest substringWithRange:NSMakeRange(44, 2)];
    buchung.buchungsSchluesselErgaenzung = [satzAndRest substringWithRange:NSMakeRange(46,3)];
    
    buchung.auftraggeberBankleitzahl = [satzAndRest substringWithRange:NSMakeRange(61, 8)];
    buchung.auftraggeberKontonummer = [satzAndRest substringWithRange:NSMakeRange(69, 10)];
    buchung.betrag = [satzAndRest substringWithRange:NSMakeRange(79, 11)];
    
    buchung.kundenName = [satzAndRest substringWithRange:NSMakeRange(93, 27)];
    buchung.auftraggeberName = [satzAndRest substringWithRange:NSMakeRange(128, 27)];
    [buchung addVerwendungszweck:[satzAndRest substringWithRange:NSMakeRange(155, 27)]];
    
    buchung.waehrung = [satzAndRest substringWithRange:NSMakeRange(182, 1)];
    if (![buchung.waehrung isEqualToString:@"1"]) {
        // use old DM Betrag position
        buchung.betrag = [satzAndRest substringWithRange:NSMakeRange(50, 11)];
    }
    
    NSInteger erweiterungenCount = [[satzAndRest substringWithRange:NSMakeRange(185, 2)] integerValue];
    erweiterungenCount-=2;
    
    // TODO: parse additions
    
    NSInteger satzLength = 256; // default satz lenght
    if (0<erweiterungenCount) {
        satzLength += (NSInteger)ceil(erweiterungenCount/4.0)*128;
    }
    
    return [satzAndRest substringFromIndex:satzLength];
}
/**
 * Parses the E Satz and returns the rest of the string
 */
- (NSString*)parseSatzE:(NSString*)satzAndRest {
    NSParameterAssert(satzAndRest && [self satzTypeForSatz:satzAndRest]==DTASatzTypeE);
    if ([satzAndRest length]<128) {
        NSLog(@"%s not long enough for E section: %@",__PRETTY_FUNCTION__,satzAndRest);
        return nil;
    }
    NSString *lengthString = [satzAndRest substringWithRange:NSMakeRange(0, 4)];
    NSInteger lengthInt = [lengthString integerValue];
    NSAssert1(lengthInt==128, @"length field should contain 0128, but it contains: %@",lengthString);

    self.dtaData.anzahlBuchungen = [satzAndRest substringWithRange:NSMakeRange(10, 7)];
    self.dtaData.kontrollsummeKontonummern = [satzAndRest substringWithRange:NSMakeRange(30, 17)];
    self.dtaData.kontrollsummeBankleitzahlen = [satzAndRest substringWithRange:NSMakeRange(47, 17)];
    
    NSRange betreageRange = NSMakeRange(17, 13);
    if ([self.dtaData.waehrung isEqualToString:@"1"]) {
        betreageRange = NSMakeRange(64, 13);
    }
    self.dtaData.kontrollsumme = [satzAndRest substringWithRange:betreageRange];
    return [satzAndRest substringFromIndex:lengthInt];
}

/**
 * returns the type of satz for an string
 */
- (DTASatzType) satzTypeForSatz:(NSString*)satz {
    if ([satz length]<5) {
        return DTASatzTypeUnknown;
    }
    NSString * satzTypeString = [satz substringWithRange:NSMakeRange(4, 1)];
    DTASatzType satzType = DTASatzTypeUnknown;
    if([satzTypeString isEqualToString:@"A"])
        satzType = DTASatzTypeA;
    else if ([satzTypeString isEqualToString:@"C"])
        satzType = DTASatzTypeC;
    else if ([satzTypeString isEqualToString:@"E"])
        satzType = DTASatzTypeE;
    
    return satzType;
}

@end
