//
//  DTAData.h
//
//  Created by Tobias Conradi on 31.12.12.
//
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
 * @class DTAData
 * @brief A model class containing the A and E part of the DTAUS file
 * and an array of DTABuchung instances (C part).
 */


@class DTABuchung;
@interface DTAData : NSObject

/*
 * A-Satz
 */

// Art der Transaktionen
//  "LB" für Lastschriften Bankseitig
//  "LK" für Lastschriften Kundenseitig
//  "GB" für Gutschriften Bankseitig
//  "GK" für Gutschriften Kundenseitig
@property (nonatomic, strong) NSString *art;
// Bankleitzahl des Auftraggebers
@property (nonatomic, strong) NSString *auftraggeberBankleitzahl;
// BLZ Absenderbank (nur belegt, wenn Dateiabsender Kreditinstitut ist, sonst 00000000)
@property (nonatomic, strong) NSString *absenderBankBankleitzahl;
// Name des Auftraggebers (max 27)
@property (nonatomic, strong) NSString *auftraggeberName;
// Dateierstellungsdatum ddMMyy
@property (nonatomic, strong) NSString *dateiDatum;
// Kontonummer des Auftraggebers
@property (nonatomic, strong) NSString *auftraggeberKonto;
// Optionale Referenznummer
@property (nonatomic, strong) NSString *referenz;
// Währung
//  ' ' = DM
//  '1' = Euro
@property (nonatomic, strong) NSString *waehrung;
// Optionales Datum ddMMyy sonst "      "
@property (nonatomic, strong) NSString *ausfuerungsDatum;

/*
 * Buchungen (C-Satz)
 */
// Array von DTABuchung
@property (nonatomic, strong) NSArray *buchungen;

/*
 * Kontrollblock (E-Satz)
 */
// Anzahl der Buchungen (aus Datei)
@property (nonatomic, strong) NSString* anzahlBuchungen;
// Kontrollsummen
@property (nonatomic, strong) NSString *kontrollsumme;
@property (nonatomic, strong) NSString *kontrollsummeKontonummern;
@property (nonatomic, strong) NSString *kontrollsummeBankleitzahlen;

- (void) addBuchung:(DTABuchung*)buchung;

@end
