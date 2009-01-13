require 'color-block'
include ColorBlock

color( :white, :blue ) { puts "white on blue?" }
color( :green ) { puts  "green?" }
color( :white, :green, :dim ) { puts "white on dark green?" }
color( :blue ) { puts "blue?" }
color( :red ) { 
  puts "red?"
  color( :cyan ) {
    puts "  cyan?"
    puts "  (this is inside a nested block)"
  }
  puts "red again?"
}

puts "all blocks are now closed. is this the original color?"
puts
puts "testing exception handling and nested blocks..."
color( :cyan ) {
  puts "cyan?"
  color( :green ) {
    puts "  green?"
    begin
      color( :red ) {
        puts "    red?"
        puts "    raising an exception..."
        raise "    test exception"
      }
    rescue
      puts "  catching exception."
      puts "  green again?" 
    end
    puts "  at this point you should have seen a message \"catching exception.\""
    puts "  was the exception caught?"
  }
  puts "cyan again?"
}
