class CircleCoordinatesGen
  attr_accessor :number_of_coordinates_to_generate
  attr_accessor :limit

  TWO = 2

  def initialize(number_of_coordinates_to_generate, limit)
    @number_of_coordinates_to_generate = number_of_coordinates_to_generate
    @limit = limit
  end

  def generate_coordinates
    arr = []
    (0..@number_of_coordinates_to_generate).each do
      arr.push(create_valid_coordinates)
    end
    arr
  end

  def create_valid_coordinates
    passes_radius_check = false
    until passes_radius_check
      x = generate_coordinate
      y = generate_coordinate
      passes_radius_check = true if calculate_radius(x, y) <= @limit
    end
    [x, y]
  end

  def generate_coordinate
    rand((-@limit)..@limit)
  end

  def calculate_radius(x, y)
    Math.sqrt(x.abs**TWO + y.abs**TWO)
  end
end
