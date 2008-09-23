= color-console
  by Greg Houston

color-console is a ruby library which makes it easy to output color text.  right now
it only supports windows.  (maybe someone on linux and mac would like to add support
for those platforms.)

Version:: 0.1.1

== LICENSE:

(The MIT License + Free Software Foundation Advertising Prohibition)

Copyright (c) 2008 Gregory N. Houston

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

Except as contained in this notice, the name(s) of the above copyright holders
shall not be used in advertising or otherwise to promote the sale, use or other
dealings in this Software without prior written authorization.

== Examples:

require 'color-console'
include Windows::ColorConsole

color( BLUE ) { "everything in this block is blue!" }

putsc RED, "putsc adds a color argument to puts"

putsc [WHITE,DARK_GREEN], "foreground and background are specified with an array"

color( WHITE, BLUE )

puts "now everything is white on blue!"

color_restore

puts "color-console remembers the original color so it can be restored!"

== History:

0.1.1 Sep 23, 2003 => Fix, restores color when an exception is thrown within a block 
argument to Windows::ColorConsole#color.  Added examples to demonstrate exception
handling.

0.1.0 Aug 22, 2008 => Initial release.