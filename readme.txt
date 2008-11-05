= color-block
  by Greg Houston

I wanted to color the output of Rake.  The problem is I dont have direct access to the
strings contained in rake tasks.  The solution is to wrap code in a block that colors the
output of everything inside the block.

Version:: 0.2.0

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

require 'color-block'
include ColorBlock

color( :blue ) { "everything in this block is blue!" }

color( :white, :blue ) do
  puts "now everything is white on blue!"
  color( :green, :black ) { "nesting is supported" }
end

color( :white, :black, :bold ) { "third parameter to specify :bold or :dim" }

== Options:

COLORS = :black, :red, :green, :yellow, :blue, :purple or :magenta,
:cyan, :white, :default
    
ATTRIBUTES = :bold, :bold_off or :dim

== Known Issues:

On windows cmd console, somtimes background colors bleeds over to the next line.  This
problem happens when the cmd window's buffer has filled up, then when it scrolls to a
new line, the previous line's background attribute appears.  The older color-console did
not exhibit this problem.  Perhapse in a later release color-block could use the older
code when it detects platform is windows.  Work arounds: clear the buffer
using the cls command; or increase the buffer size; or avoid background colors.

By design, the ColorStack class which tracks color changes to restore them later only
supports single-threaded operation (it is a singleton).  If different threads use color blocks
the resulting restored colors are unpredictable.

== History:

0.2.0 Nov 05, 2008 => Removed the Windows specific code in favor of a cross-platform
solution.  Changed colors from constants to symbols (BLUE to :blue).  After using this
library in a large Rake build script, removed the putsc method since it wasn't being used.  

0.1.1 Sep 23, 2008 => Fix, restores color when an exception is thrown within a block 
argument to Windows::ColorConsole#color.  Added examples to demonstrate exception
handling.

0.1.0 Aug 22, 2008 => Initial release.
