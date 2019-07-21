class Dog
  def initialize(name, breed, age, bark, favorite_foods)
    @name = name
    @breed = breed
    @age = age
    @bark = bark

    @favorite_foods = favorite_foods
  end

  def name
    @name
  end

  def breed
    @breed
  end

  def age
    @age
  end

  def age=(age)
    @age = age
  end

  def bark
    if @age > 3
      @bark.upcase
    else
      @bark.downcase
    end
  end

  def favorite_foods
    @favorite_foods
  end

  def favorite_food?(item)
    @favorite_foods.map(&:downcase).include?(item.downcase)
  end
end

# describe "#initialize" do
#     it "should accept a name (string), breed (string), age (number), bark (string), and favorite_foods (array) as arguments" do
#       dog
#     end

#     it "should set the instance variables @name, @breed, @age, @bark, @favorite_foods" do
#       expect(dog.instance_variable_get(:@name)).to eq("Fido")
#       expect(dog.instance_variable_get(:@breed)).to eq("German Shepard")
#       expect(dog.instance_variable_get(:@age)).to eq(3)
#       expect(dog.instance_variable_get(:@bark)).to eq("Bork!")
#       expect(dog.instance_variable_get(:@favorite_foods)).to eq(["Bacon", "Chicken"])
#     end
#   end
