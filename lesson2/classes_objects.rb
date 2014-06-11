# Part I 1. Create a class called MyCar. When you initialize a new instance or object of the class, allow the user to define some instance variables that tell us the year, color, and model of the car. Create an instance variable that is set to 0 during instantiation of the object to track the current speed of the car as well. Create instance methods that allow the car to speed up, brake, and shut the car off.

class MyCar
  attr_accessor :color, :model, :speed, :miles, :gallons
  attr_reader :year
  
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
    @miles = 50
    @gallons = 50
  end
  
  def speed_up(speed)
    @speed = speed
    puts "your #{self.year} #{self.color} #{self.model} is now traveling #{speed} mph"
  end
  
  def brakes(speed)
    @speed = speed
    puts "your #{self.year} #{self.color} #{self.model} is now traveling #{speed} mph"
  end
  
  def shut_down
    @speed = 0
    puts "you've shut down your #{self.year} #{self.color} #{self.model} and your speed is #{speed}"
  end
  
  # Part I 3. You want to create a nice interface that allows you to accurately describe the action you want your program to perform. Create a method called spray_paint that can be called on an object and will modify the color of the car.
  def spray_paint(color)
    self.color = color
    puts "color changed to #{self.color}"
  end
  
  # Part II: 1. Add a class method to your MyCar class that calculates the gas mileage of any car.
  def gas_mileage(miles, gallons)
    self.miles = miles
    self.gallons = gallons
    puts "Your gas mileage is #{miles / gallons}"
  end
  
  # Part II 2. Override the to_s method to create a user friendly print out of your object.
  def to_s
    puts "You are driving a #{year} #{color} #{model} that gets #{miles / gallons} mpg"
  end
end

car = MyCar.new('1998', 'Silver', 'Honda Civic')
puts "floor it!"
car.speed_up(199)
puts "watch out for the po-po!"
car.brakes(50)
puts "Pull over!"
car.shut_down

# Part I 2. Add an accessor method to your MyCar class to change and view the color of your car. Then add an accessor method that allows you to view, but not modify, the year of your car.

# change color
puts car.color = 'Black'
# Black
puts car.year
# 1998

# change color using method
car.spray_paint('Blue')

# mileage
car.gas_mileage(500, 2)

# friendly output
car.to_s
# => You are driving a 1998 Blue Honda Civic that gets 250 mpg

# Part II 3. When running the following code...

class Person
  # attr_reader :name => attr_reader doesn't allow changes
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
puts bob.name = "Bob"


# test.rb:9:in `<main>': undefined method `name=' for
#   <Person:0x007fef41838a28 @name="Steve"> (NoMethodError)