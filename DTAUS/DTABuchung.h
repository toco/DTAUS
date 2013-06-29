//
//  DTABuchung.h
//
//  Created by Tobias Conradi on 31.12.12.
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

#import <Foundation/Foundation.h>

/*!
 * @class DTABuchung
 * @brief a model class to store the C part of DTAUS files.
 */
@interface DTABuchung : NSObject
// BLZ erstbeteiligte Bank (optional) default='00000000'
@property (nonatomic, strong) NSString *ersteBankBankleitzahl;
@property (nonatomic, strong) NSString *kundenBankleitzahl;
@property (nonatomic, strong) NSString *kundenKontonummer;
@property (nonatomic, strong) NSString *kundenName; // max 27

@property (nonatomic, strong) NSString *auftraggeberBankleitzahl;
@property (nonatomic, strong) NSString *auftraggeberKontonummer;
@property (nonatomic, strong) NSString *auftraggeberName; // max 27

// NSString array
@property (nonatomic, copy) NSArray *verwendungszweck;
// Währung
//  ' ' = DM
//  '1' = Euro
@property (nonatomic, strong) NSString *waehrung;

// default = '0000000000000'
@property (nonatomic, strong) NSString *interneKundennummer;
@property (nonatomic, strong) NSString *buchungsSchluessel;
@property (nonatomic, strong) NSString *buchungsSchluesselErgaenzung;
//  Betrag mit 9 Vorkommastellen und 2 Nachkommastellen ohne Trennzeichen
@property (nonatomic, strong) NSString *betrag;

- (void)addVerwendungszweck:(NSString *)verwendungszweck;

@end
