# Create a method that takes an array as a parameter. Within that method, try calling methods that do not mutate the caller. How does that affect the array outside of the method? What about when you call a method that mutates the caller within the method?

def mutate(obj)
  obj.pop
end

def no_mutate(obj)
  obj.uniq
end

arr1 = [1,2,2,3,3]
mutate(arr1)

p arr1 # => [1, 2, 3] mutated

arr2 = [1,2,2,4,4,5]
no_mutate(arr2)

p arr2 # => [1, 2, 2, 4, 4, 5] not mutated