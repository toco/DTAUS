DTAUS
=====

A simple DTAUS parser written in Objective-C.

DTAUS is a file format used in the german bank sector for bank transfers.
I wrote the parser to convert DTAUS files created by my book keeping software to BezahlCode URLs.

With a small [category](https://gist.github.com/toco/5892319) and the offical [BezahlCode libray](http://www.bezahlcode.de/informationen/), it's easy to create an app that converts DTAUS files to BezahlCode URLs and opens them with e.g. OutBank.


Usage
-----

```objective-c
    DTAData *aDTAData = [DTAParser parseData:dtausData];
    NSString *senderBankAccount = aDTAData.auftraggeberKonto;
    NSString *senderSortCode = aDTAData.auftraggeberBankleitzahl;	
```

Other example: [https://gist.github.com/toco/5892319](https://gist.github.com/toco/5892319)

File format info:
-----------------
[http://de.wikipedia.org/wiki/DTAUS](http://de.wikipedia.org/wiki/DTAUS)

[http://www.infodrom.org/projects/dtaus/dtaus.html](http://www.infodrom.org/projects/dtaus/dtaus.html)

License
=======

Copyright (c) 2013 Tobias Conradi

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.