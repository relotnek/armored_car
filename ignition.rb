require 'bin/armor'
x = ArmoredCar.new()

x.directify

puts "GENERATING"
x.generate

puts "LOAD: Give the absolute path of your file:"
x.loader(gets.chomp!)

puts "DECRYPT: Give the absolute path of your encrypted file:"
x.unloader(gets.chomp!)