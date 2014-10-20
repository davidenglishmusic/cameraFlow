class CircleCoordinatesGen

  attr_accessor :number_of_coordinates_to_generate
  attr_accessor :limit

  Two = 2

  def initialize(number_of_coordinates_to_generate, limit)
    @number_of_coordinates_to_generate = number_of_coordinates_to_generate
    @limit = limit
  end

  def generate_coordinates()
    arr = []
    (0..@number_of_coordinates_to_generate).each do
      radius_condition = false
      while !radius_condition do
        x = generate_coordinate()
        y = generate_coordinate()
        if calculate_radius(x,y) <= @limit
          radius_condition = true
        end
      end
      arr.push([x,y])
    end
    arr
  end

  def generate_coordinate()
    rand((-@limit)..@limit)
  end

  def calculate_radius(x,y)
    Math.sqrt(x.abs ** Two + y.abs ** Two)
  end

end
