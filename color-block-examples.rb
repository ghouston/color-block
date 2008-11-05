require 'color-block'
include ColorBlock

color( :white, :blue ) { puts "is this white on blue?" }
color( :green ) { puts  "is this green?" }
color( :white, :green, :dim ) { puts "is this white on dark green?" }
color( :blue ) { puts "is this blue?" }
color( :red ) { 
  puts "is this red?"
  color( :cyan ) {
    puts "  is this cyan?"
    puts "  (this is inside a nested block)"
  }
  puts "is this red again?"
}

puts "is this the original color?"

puts "testing exception handling and nested blocks..."
color( :cyan ) {
  puts "is this cyan?"
  color( :green ) {
    puts "  is this green?"
    begin
      color( :red ) {
        puts "    is this red?"
        puts "    raising an exception..."
        raise "    test exception"
      }
    rescue
      puts "  exception caught."
      puts "  is this green again?" 
    end
    puts "  was the exception caught?"
  }
  puts "is this cyan again?"
}
