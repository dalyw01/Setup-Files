puts "#################### Printing Variables ####################"

a = "derp"
b = 1
c = 9.7
d = 'l'
e = nil
f = true
g = false

puts ": #{a}"
etc..

puts "#################### Making A Class ####################"

class Animal
    attr_accessor :name, :age, :trait
end

animal_1 = Animal.new

animal_1.name = "Alan"
animal_1.age   = 20

puts "#{animal_1.name}"
puts "#{animal_1.age}"

puts "#################### Inheritance ####################"

class Dog < Animal
    # Inhereting
end

class Cat < Animal
    # Inhereting
end

class Fish < Animal
    attr_accessor :fins  # Adding new attribute
end

fish_1 = Fish.new

fish_1.name  = "Alan"
fish_1.age   = 20
fish_1.trait = "Dodgey leg"
fish_1.fins  = "yes he has fins" 

puts "#{fish_1.fins}"

puts "#################### Objects With Methods ####################"

class Person

    def talk
      puts "Hello how are you? :D"
    end

    def burp
      puts "** BURPS **"
    end

    def addNumbers( a , b , c=25 )
      puts (a + b)
      puts "#{c}"
    end

end

person_1 = Person.new
person_1.talk
person_1.burp
person_1.addNumbers( 2 , 6 )

puts "#################### Finding What Class An Object Belongs To ####################"

puts "#{Cat.class}"
puts "#{person_1.class}"
puts "#{fish_1.class}"

puts "#################### Conditionals ####################"  

name = "Andreww"
 
if name == "Andrew"
    puts "x0x0x0x0x0x"
end
 
if name == "Andrew"
    puts "Hello Andrew"

elsif name == "medium"
    puts "derp"

else
    puts "Hello someone else"
end

puts "#################### Loops ####################"  

# http://www.tutorialspoint.com/ruby/ruby_loops.htm
puts "x.times all needs to be on the one line"

4.times do puts "nom nom" end
4.times {  puts "herpa derpppp" }

4.upto(7)   { puts "zzzz zzzz zzz" }
7.downto(4) { puts "lolo lolo lol" }

0.step(15,5) { puts "HAHA HAHA HAHA" }
0.step(15,5) { |x| puts x }

puts "#################### Constants ####################"  

William = 24
puts "#{William}"

# Note that Ruby will throw a warning since you are editing a constant
# Constants start with a CAPITAL!

William = 25
puts "#{William}"

puts "#################### Multi-line String Variables ####################"  

# http://commandercoriander.net/blog/2014/11/09/a-multiline-string-cheatsheet-for-ruby/

my_str = <<-FOO
This is the first line.
This is the second line.  0000000000000000000000
1 + 1 is #{1 + 1}.
FOO

puts my_str

my_str = %q(
This is the first line.
This is the second line. aaaaaaaaaaaaaaaaaaaaaa
1 + 1 is #{1 + 1}.
)

puts my_str

my_str = %Q(
This is the first line.
This is the second line. bbbbbbbbbbbbbbbbbbb 
1 + 1 is #{1 + 1}.
)

puts my_str

my_str = %(
This is the first line.
This is the second line. cccccccccccccccccc
1 + 1 is #{1 + 1}.
)

puts my_str

puts "#################### Regular Expressions ####################"  

puts "fatBucky_".sub( "fat" , "super_cute_")

puts "fatBucky_fat".gsub( "fat" , "super_cute_")

message = "yo, what the hell do you want?"

# Rip out the 1st 2 characters and replace them
puts message.sub( /^../ , "Excuse me sir?" )

puts "#################### Regular Expressions 2.0 ####################"  

ryan_string = "Ryan: This is a test"

if ryan_string =~ /(^.*)(:)(.*)/i
   puts $1
   puts $3
end

puts "#################### Arrays ####################"

array1 = [ "derp" , 6 , 1.0 ]

puts array1
puts array1[1]

puts "#################### Arrays 2.0 ####################"

array1.each do | number |
  puts "This is me printing the Ruby way: #{number}"
end

puts "#################### Arrays Push/Pop ####################"

a = [ "a", "b", "c" ]
a.push("d", "e", "f")
puts a

puts "Now for some pop..."

b = [ "a", "b", "c", "d" ]
b.pop()
puts b

puts "Now to pop multiple items..."

b = [ "a", "b", "c", "d" ]
b.pop(2)
puts b

puts "The length of array a is [#{a.length}]" 
puts "The length of array b is [#{b.length}]" 

puts "\n#################### Hashes In Ruby ####################"

student_ages =
{
    "Jack" => 10,
    "Jill" => 12,
    "Bob"  => 14
}


puts "\n#################### Sorting Hash Ruby ####################"

temp = Hash[ new_hash.sort_by { |key, val| key } ]
temp.each do |x,y|
  @fileHtml.puts "<p>#{x} -> #{y}</p>"
end
@side_links.push("#{new_title}")


puts "\n#################### Passing Hash's Into Functions ####################"

def printHashs( new_hash_1 , new_hash_2 )
  puts new_hash_1.values
  puts "+-------+"
  puts new_hash_2.values
end

printHashs( student_ages , hash )

puts "\n#################### Outputting Command Line Arguements ####################\n"

arg_0 = ARGV[0] 
arg_1 = ARGV[1]
arg_2 = ARGV[2] 

puts arg_0
puts arg_1
puts arg_2

puts "\nOr just output them straight away without assigning any variable!\n\n"

puts ARGV[0]
puts ARGV[1]
puts ARGV[2] 

puts "\n#################### Concatenating In Ruby ####################\n"

puts "STEP : Calling method [load_vpid] from [player_steps.rb] with paramaters [#{vpid}] , [#{kind}] , [#{env}] "

    © 2017 GitHub, Inc.
    Terms
    Privacy
    Security
    Status
    Help

    Contact GitHub
    API
    Training
    Shop
    Blog
    About

