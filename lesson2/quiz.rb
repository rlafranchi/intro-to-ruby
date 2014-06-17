# 1. Name what each of the below is:

# a = 1 
# => ex. a is a local variable, and is a Fixnum object with value 1 

# @a = 2
# => is an instance variable

# user = User.new
# => an object defined as a new instance of class User

# user.name
# => instance variable or method called on the class object user 

# user.name = "Joe"
# => updating instance variable of class object user

# 2. How does a class mixin a module?
module NewModule
  def mod_method
    puts "I'm a module"
  end
end

class Included
  include NewModule
end

included = Included.new
included.mod_method
# => "I'm a module"

# 3. What's the difference between class variables and instance variables?
# class variables are defined with two @'s and are defined on the class level where instance variables are defined with single @ at the method level.  For example, class variables can be used to count the number of instances of a class that have been created.  Instance variables can be different for each instance object of a class.

# 4. What does attr_accessor do?
# it is used to be able to update an instance variable.

# from solution
class Dog
 attr_accessor :name
end

# This is the same without using 'attr_accessor'. 
class Dog
 def name
   @name
 end

 def name=(new_name)
   @name = new_name
 end
end

# 5. How would you describe this expression: Dog.some_method
# calls some_method on the class Dog

# 6. In Ruby, what's the difference between subclassing and mixing in modules?
# subclassing can be described as a child of a parent class or dependent on the parent class, where a module can be included in any class.

# 7. Given that I can instantiate a user like this: User.new('Bob'), what would the initialize method look like for the User class?
class User
  def initialize(n)
    @name = n
  end
end

# 8. Can you call instance methods of the same class from other instance methods in that class?
# Yes, ie.
class Example
  def method_one
    puts "method one"
  end
  def method_two
    method_one
  end
end

example = Example.new
example.method_two
# => "method_one"

# 9. When you get stuck, what's the process you use to try to trap the error?
# read the error and try to figure it out, if not then use pry
# require 'pry' and place a binding.pry above the line where an error is occuring to try further debug