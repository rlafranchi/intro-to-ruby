# 1. Create a superclass called Vehicle for your MyCar class to inherit from and move the behavior that isn't specific to the MyCar class to the superclass. Create a constant in your MyCar class that stores information about the vehicle that makes it different from other types of Vehicles.

class Vehicle
  # 2. Add a class variable to your superclass that can keep track of the number of objects created that inherit from the superclass. Create a method to print out the value of this class variable as well.
  @@number_of_vehicles = 0
  
  def self.total_number_of_vehicles
    puts "Total number of vehicles: #{@@number_of_vehicles}"
  end
  
  def gas_mileage(miles, gallons)
    puts "Your gas mileage is #{miles / gallons}"
  end
  
  # 5. Move all of the methods from the MyCar class that also pertain to the MyTruck class into the Vehicle class. Make sure that all of your previous method calls are working when you are finished.
  attr_accessor :color, :model, :speed
  attr_reader :year
  
  def initialize(year, color, model)
    @@number_of_vehicles += 1
    @year = year
    @color = color
    @model = model
    @speed = 0
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

  def spray_paint(color)
    self.color = color
    puts "color changed to #{self.color}"
  end
  
  # 6. Write a method called age that calls a private method to calculate the age of the vehicle. Make sure the private method is not available from outside of the class. You'll need to use Ruby's built-in Time class to help.
  def age
    puts "Your #{self.model} is #{years_old} years old"
  end
  
  private
  
  def years_old
    year = self.year.to_i
    now = Time.now.year.to_i
    now - year
  end
end

# 3. Create a module that you can mix in to ONE of your subclasses that describes a behavior unique to that subclass.

module FourWheel
  def four_wheel_drive
    puts "This vehicle has Four Wheel Drive"
  end
end

class MyCar < Vehicle
  DOORS = 4
  
  def to_s
    puts "Your car is a #{year} #{color} #{model}"
  end
end

class MyTruck < Vehicle
  DOORS = 2
  
  include FourWheel
  
  def to_s
    puts "Your truck is a #{year} #{color} #{model}"
  end
end

# 4 Print to the screen your method lookup for the classes that you have created.

puts Vehicle.ancestors
puts MyCar.ancestors
puts MyTruck.ancestors

# 5. make sure previous calls work
car = MyCar.new('1998', 'Silver', 'Honda Civic')
puts "floor it!"
car.speed_up(199)
puts "watch out for the po-po!"
car.brakes(50)
puts "Pull over!"
car.shut_down
puts car.color = 'Black'
puts car.year
car.spray_paint('Blue')
car.gas_mileage(500, 2)
car.to_s

car.age