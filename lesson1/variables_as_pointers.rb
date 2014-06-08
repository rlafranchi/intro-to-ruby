# variables as pointers

a = "hi there"
puts a # hi there
b = a
puts a # hi there
puts b # hi there
a = "not here"
puts a # not here
puts b # hi there


a = "hi there"
b = a
puts a # hi there
puts b # hi there
a << ", Bob!"
puts a # hi there, Bob!
puts b # hi there, Bob!


a = [1, 2, 3, 3]
b = a
c = a.uniq
p a # [1, 2, 3, 3]
p b # [1, 2, 3, 3]
p c # [1, 2, 3]


a = [1, 2, 3, 3]
b = a
c = a.uniq!
p a # [1, 2, 3]
p b # [1, 2, 3]
p c # [1, 2, 3]

def test(b)
  b.map {|letter| "I like the letter: #{letter}"}
end

a = ['a', 'b', 'c']
p test(a) # ["I like the letter: a", "I like the letter: b", "I like the letter: c"]
p a # ["a", "b", "c"]

def test1(b)
  b.map! {|letter| "I like the letter: #{letter}"}
end

a = ['a', 'b', 'c']
p test1(a) # ["I like the letter: a", "I like the letter: b", "I like the letter: c"]
p a # ["I like the letter: a", "I like the letter: b", "I like the letter: c"]