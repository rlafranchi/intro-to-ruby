# 1. How do we create an object in Ruby? Give an example of the creation of an object.

class Object
  include Module # included from exercise 2
end

new_object = Object.new

# 2. What is a module? What is its purpose? How do we use them with our classes? Create a module for the class you created in exercise 1 and include it properly.

# A module is a way to define methodes outside of a class and can be included inside a class as a "mixin"

module Module
  def method
  end
end