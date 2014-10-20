class PositionByFrameGen

  attr_accessor :starting_coordinate
  attr_accessor :ending_coordinate
  attr_accessor :starting_frame
  attr_accessor :ending_frame
  attr_accessor :horizontal_coordinate_difference
  attr_accessor :vertical_coordinate_difference
  attr_accessor :horizontal_half
  attr_accessor :vertical_half
  attr_accessor :midpoint
  attr_accessor :@total_number_of_frames
  attr_accessor :direction

  Two = 2

  def initialize(starting_coordinate, ending_coordinate, starting_frame, ending_frame)
    @starting_coordinate = starting_coordinate
    @ending_coordinate = ending_coordinate
    @starting_frame = starting_frame
    @ending_frame = ending_frame
    @horizontal_coordinate_difference = (@ending_coordinate[0]) - (@starting_coordinate[0]).abs
    @horizontal_half = @horizontal_coordinate_difference / Two
    @vertical_coordinate_difference = (@ending_coordinate[1] - @starting_coordinate[1]).abs
    @vertical_half = @vertical_coordinate_difference / Two
    @midpoint = calculate_midpoint()
    @total_number_of_frames = @ending_frame - @starting_frame
    @direction = determine_direction()
  end

  def determine_direction
    if @ending_coordinate[0] > @starting_coordinate[0] && @ending_coordinate[1] > @starting_coordinate[1]
      "forwardAndUp"
    elsif @ending_coordinate[0] > @starting_coordinate[0]
      "forwardAndDown"
    elsif @ending_coordinate[1] > @starting_coordinate[1]
      "backAndUp"
    else
      "backAndDown"
    end
  end

  def calculate_midpoint()
    x_midpoint = 0
    y_midpoint = 0
    if @starting_coordinate[0] > @ending_coordinate[0]
      x_midpoint = @ending_coordinate[0] - @horizontal_half
    else
      x_midpoint = @ending_coordinate[0] - @horizontal_half
    end
    if @starting_coordinate[1] > @ending_coordinate[1]
      y_midpoint = @starting_coordinate[1] - @vertical_half
    else
      y_midpoint = @ending_coordinate[1] - @vertical_half
    end
    [x_midpoint, y_midpoint]
  end

  def calculate_y(x)
    #Amplitude * Math.sin((2 * Math::PI / frequency) * ( x - horizontal_offset)) + vertical_offset
    @vertical_half * Math.sin((Math::PI / @horizontal_coordinate_difference) * (x - @midpoint[0])) + @midpoint[1]
  end

  def print_formula()
    p "#{@vertical_half} * sin((pi / #{@horizontal_coordinate_difference}) * (x - #{@midpoint[0]})) + #{@midpoint[1]}"
  end

  def get_all_frame_coordinates()
    arr = []
    x_increment = (@ending_coordinate[0] - @starting_coordinate[0].abs).to_f/@total_number_of_frames
    current_x_coordinate = @starting_coordinate[0]
    arr.push([@starting_frame, @starting_coordinate])
    case @direction
    when "forwardAndUp"
      arr = forward_and_up(arr, x_increment)
    when "forwardAndDown"
      arr = forward_and_down(arr, x_increment)
    when "backAndUp"
      arr = back_and_up(arr, x_increment)
    else
      arr = back_and_down(arr, x_increment)
    end
    arr.push([@ending_frame, @ending_coordinate])
  end

  def forward_and_up(initial_arr, x_increment)
    frame_arr = []
    x_arr = []
    y_arr = []
    current_x_coordinate = @starting_coordinate[0] + x_increment
    ((@starting_frame + 1)..(@ending_frame - 1)).each do |frame|
      frame_arr.push(frame)
      x_arr.push(current_x_coordinate)
      current_x_coordinate += x_increment
    end
    x_arr.each do |x|
      y_arr.push(calculate_y(x))
    end
    coordinate_arr = x_arr.zip(y_arr)
    combined_arr = frame_arr.zip(coordinate_arr)
    initial_arr.concat(combined_arr)
  end

  def forward_and_down(initial_arr, x_increment)
    frame_arr = []
    x_arr = []
    y_arr = []
    current_x_coordinate = @starting_coordinate[0] + x_increment
    ((@starting_frame + 1)..(@ending_frame - 1)).each do |frame|
      frame_arr.push(frame)
      x_arr.push(current_x_coordinate)
      current_x_coordinate += x_increment
    end
    x_arr.each do |x|
      y_arr.push(calculate_y(x))
    end
    coordinate_arr = x_arr.zip(y_arr.reverse)
    combined_arr = frame_arr.zip(coordinate_arr)
    initial_arr.concat(combined_arr)
  end

  def back_and_up(initial_arr, x_increment)
    frame_arr = []
    x_arr = []
    y_arr = []
    current_x_coordinate = @starting_coordinate[0] + x_increment
    ((@starting_frame + 1)..(@ending_frame - 1)).each do |frame|
      frame_arr.push(frame)
      x_arr.push(current_x_coordinate)
      current_x_coordinate += x_increment
    end
    x_arr.each do |x|
      y_arr.push(calculate_y(x))
    end
    coordinate_arr = x_arr.zip(y_arr)
    combined_arr = frame_arr.zip(coordinate_arr)
    initial_arr.concat(combined_arr)
  end

  def back_and_down(initial_arr, x_increment)
    frame_arr = []
    x_arr = []
    y_arr = []
    current_x_coordinate = @starting_coordinate[0] + x_increment
    ((@starting_frame + 1)..(@ending_frame - 1)).each do |frame|
      frame_arr.push(frame)
      x_arr.push(current_x_coordinate)
      current_x_coordinate += x_increment
    end
    x_arr.each do |x|
      y_arr.push(calculate_y(x))
    end
    coordinate_arr = x_arr.zip(y_arr.reverse)
    combined_arr = frame_arr.zip(coordinate_arr)
    initial_arr.concat(combined_arr)
  end

end
