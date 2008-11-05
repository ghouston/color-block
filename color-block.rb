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
begin
  require 'Win32/Console/ANSI' if PLATFORM =~ /win32/
rescue LoadError
  raise 'You must gem install win32console to use color on Windows'
end

require 'singleton'
module ColorBlock
  class ColorStack
    include Singleton
    
    def initialize
      @stack = []
    end
    
    def push( code )
      @stack.push code
    end
    
    def pop
      code = @stack.pop
    end
    
    def last
      @stack.last
    end
    
    def reset
      @stack = []
    end
  end
    
  COLORS = { :black => 30, :red => 31, :green => 32,
    :yellow => 33, :blue => 34, :purple => 35, :magenta => 35, :cyan => 36,
    :white => 37, :default => 39 }
    
  ATTRIBUTES = { :bold => 1, :bold_off => 22, :dim => 22 }
  
  def color( foreground, background = nil, attribute = :bold )
    if background.nil? then
      code = "\033[#{ATTRIBUTES[attribute]};#{COLORS[foreground]}m"
    else
      code = "\033[#{ATTRIBUTES[attribute]};#{COLORS[foreground]};#{COLORS[background]+10}m"
    end
    ColorStack.instance.push code
    print "\33[0;40m"
    print code
    if block_given? then
      begin
        yield
      rescue
        ColorStack.instance.pop
        color_restore
        #color_reset
        raise # rethrow the exception
      end
      ColorStack.instance.pop
      color_restore
      #color_reset
    end
  end

  def color_restore
    code = ColorStack.instance.last
    print (code.nil?) ? "\33[0m" : code
  end
  
  def color_reset
    ColorStack.instance.reset
    print "\33[0;40m"
  end
end
