# color-console
#
# see readme.txt and color-console-examples.rb for details.
#
# License:
# 
# (The MIT License + Free Software Foundation Advertising Prohibition)
#
# Copyright (c) 2008 Gregory N. Houston
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
# 
# Except as contained in this notice, the name(s) of the above copyright holders
# shall not be used in advertising or otherwise to promote the sale, use or other
# dealings in this Software without prior written authorization.require 'windows/console'
require 'windows/console'

module Windows::ColorConsole
  include Windows::Console

  # see also http://msdn.microsoft.com/en-us/library/ms682088(VS.85).aspx Character Attributes
  # for more information about these codes.
  BLACK = 0
  DARK_BLUE = 1
  DARK_GREEN = 2
  DARK_CYAN = 3
  DARK_RED = 4
  DARK_PURPLE = 5
  DARK_YELLOW = 6
  WHITE = 7
  GREY = 8
  BLUE = 9
  GREEN = 10
  CYAN = 11
  RED = 12
  PURPLE = 13
  YELLOW =14
  BRIGHT_WHITE = 15

  def color( foreground, background = nil )
    @__color_console_handle ||= GetStdHandle(-11) # i have no idea why -11 is used, need to lookup sometime
    prior_color = current_color()
    @__color_console_original ||= prior_color
    new_color = (background.nil?) ? foreground : foreground + (background * 16)
    SetConsoleTextAttribute( @__color_console_handle, new_color )
    if block_given? then
      yield
      SetConsoleTextAttribute( @__color_console_handle, prior_color )
    end
  end

  def color_restore
    if block_given? then
      color( @__color_console_original, &block )
    else
      color( @__color_console_original )
    end
  end
  
  def current_color
    @__color_console_handle ||= GetStdHandle(-11) # i have no idea why -11 is used, need to lookup sometime
    lpBuffer = ' ' * 22
    GetConsoleScreenBufferInfo( @__color_console_handle, lpBuffer )
    # see http://msdn.microsoft.com/en-us/library/ms682093(VS.85).aspx
    # to understand buffer info elements
    return lpBuffer.unpack("SSSSSssssSS")[4]
  end
  
  def putsc( newcolor, message )
    color( *newcolor ) { puts message }
  end
end
