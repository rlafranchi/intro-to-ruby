# 1 Create a local variable and modify it at an inner scope (in between a do/end block). You can try
  arr = [1, 2, 3, 4, 5, 5]
  s = 0 # s is defined outside scope
  # a) re-assigning the variable to something else
  arr.each do |a|
    s += a
  end
  puts s # => 15
  # b) call a method that doesn’t mutate the caller
  def no_mutate(num)
    count = num
  end
  # count and num not defined outside scope
  puts no_mutate(8) # => 8
  
  # c) call a method that mutates the caller.
  def mutate(num)
    num += 1
  end
  puts mutate(8)  # => 9

# 2 Create a local variable at an inner scope (within a do/end block) and try to reference it in the outer scope. What happens when you have nested do/end blocks?
  # b = 5
  arr.each do |i|
    b = i
    3.times do
      b = 10
    end
    puts b # defined as 10
  end
  puts b # undefined variable outside of scope