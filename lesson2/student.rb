# 7. Create a class 'Student' with attributes name and grade. Do NOT make the grade getter public, so joe.grade will raise an error. Create a better_grade_than? method, that you can call like so...

class Student
  attr_accessor :name
  
  def initialize(n,g)
    @name = n
    @grade = g
  end
  
  def better_grade_than?(other_student)
    grade > other_student.grade
  end
  
  protected
  
  def grade
    @grade
  end
end

joe = Student.new("Bob", 90)
bob = Student.new("Joe", 84)
if joe.better_grade_than?(bob)
  puts "#{joe.name} beat #{bob.name}"
end

# 8 NoMethodError: private method `hi' called for #<Person:0x007ff61dbb79f0>
#   from (irb):8
#   from /usr/local/rvm/rubies/ruby-2.0.0-rc2/bin/irb:16:in `<main>'
# This error meains that a private method was called on the class.  Private methods are not available outside of the class.