//
//  DTAParser.h
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

#import <Foundation/Foundation.h>
@class DTAData;
@class DTABuchung;

/*!
 * @class DTAParser
 * @brief DTAParser is used to parse DTAUS files and returns the parsed data as a DTAData instance.
 *
 * http://www.infodrom.org/projects/dtaus/dtaus.html
 * http://de.wikipedia.org/wiki/DTAUS
 *
 */

@interface DTAParser : NSObject


/*!
 * Parses DTAUS-data and returns a DTAData instance containing the parsed transferals.
 *
 * @param data NSASCIIStringEncoding encoded data with contents of an DTAUS file.
 * @return Returns a DTAData instance containing the parsed transferals.
 */

+ (DTAData*)parseData:(NSData*)data;
/*!
 * Parses a DTAUS-string and returns a DTAData object containing the parsed transferals.
 *
 * @param dtaString a string with the contens of an DTAUS file.
 * @return Returns a DTAData instance containing the parsed transferals.
 */
+ (DTAData*)parseString:(NSString*)dtaString;

@end
