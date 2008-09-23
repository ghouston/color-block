require 'color-console'

include Windows::ColorConsole

color( WHITE, BLUE )
puts "is this white on blue?"

putsc GREEN, "is this green?"
puts "is this white on blue again?"

putsc [WHITE,DARK_GREEN], "is this white on dark green?"

color( BLUE )
puts "is this blue?"

color( RED )
puts "is this red?"

color( CYAN ) {
  puts "is this cyan?"
  puts "(this is inside a block)"
}
puts "is this red again?"

color_restore()
puts "is this the original color?"

puts "testing exception handling and nested blocks..."
color( CYAN ) {
  puts "is this cyan?"
  color( GREEN ) {
    puts "is this green?"
    begin
      color( RED ) {
        puts "is this red?"
        puts "raising an exception..."
        raise "test exception"
      }
    rescue
      puts "exception caught."
      puts "is this green again?" 
    end
    puts "was the exception caught?"
  }
  puts "is this cyan again?"
}
