require('pry')

# using pry in a method
def bad_method(msg)
  binding.pry
  puts "=> #{msg}" + 3
end


def say(msg)
  puts "=> #{msg}"
end

say "Enter first number:"
num1 = gets.chomp.to_i

say "Enter second number:"
num2 = gets.chomp.to_i

say "1) add 2) subtract 3) multiply 4) divide"
operator = gets.chomp.to_i

[1,2,3].each do |e|
  num2 = e
  count = e # not available to outer scope
end

[1,2,3].each {|e| }
# puts count => error
puts num2 # 3

if operator == 1
  result = num1 + num2
elsif operator == 2
  result = num1 - num2
elsif operator == 3
  result = num1 * num2
elsif operator == 4
  result = num1 / num2
end

puts "Result is #{result}"