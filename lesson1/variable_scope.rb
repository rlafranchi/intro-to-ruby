# 1 Create a local variable and modify it at an inner scope (in between a do/end block). You can try
  arr = [1, 2, 3, 4, 5]
  # a) re-assigning the variable to something else
  arr.each do |a|
    s = 0
    s += a
  end
  # b) call a method that doesn’t mutate the caller
  def no_mutate(array)
    array.uniq
  end
  no_mutate(arr)
  p arr #
  # c) call a method that mutates the caller.
  def mutate(array)
    array.pop
  end
  1.times do |a|
    mutate(arr)
    arr.unshift[a]
  end
  p arr # => [1, 2, 3, 4]

# 2 Create a local variable at an inner scope (within a do/end block) and try to reference it in the outer scope. What happens when you have nested do/end blocks?
  # b = 5
  arr.each do |i|
    c = i
    b = c + i
    3.times do |x|
      b *= x
    end
    puts b # defined
  end
  puts b # undefined variable outside of scope