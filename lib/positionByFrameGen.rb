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
  attr_accessor :total_number_of_frames
  attr_accessor :direction

  TWO = 2.0
  FIVE = 5
  TEN = 10

  def initialize(starting_coordinate, ending_coordinate, starting_frame, ending_frame)
    @starting_coordinate = starting_coordinate
    @ending_coordinate = ending_coordinate
    @starting_frame = starting_frame
    @ending_frame = ending_frame
    @horizontal_coordinate_difference = calculate_absolute_distance(@starting_coordinate[0], @ending_coordinate[0])
    @horizontal_half = @horizontal_coordinate_difference / TWO
    @vertical_coordinate_difference = calculate_absolute_distance(@starting_coordinate[1], @ending_coordinate[1])
    @vertical_half = @vertical_coordinate_difference / TWO
    calculate_midpoint
    @total_number_of_frames = @ending_frame - @starting_frame
    @direction = determine_direction
  end

  def determine_direction
    if @ending_coordinate[0] == @starting_coordinate[0] && @ending_coordinate[1] == @starting_coordinate[1]
      'none'
    elsif @ending_coordinate[0] > @starting_coordinate[0] && @ending_coordinate[1] == @starting_coordinate[1]
      'forward'
    elsif @ending_coordinate[0] < @starting_coordinate[0] && @ending_coordinate[1] == @starting_coordinate[1]
      'back'
    elsif @ending_coordinate[0] == @starting_coordinate[0] && @ending_coordinate[1] > @starting_coordinate[1]
      'up'
    elsif @ending_coordinate[0] == @starting_coordinate[0] && @ending_coordinate[1] < @starting_coordinate[1]
      'down'
    elsif @ending_coordinate[0] > @starting_coordinate[0] && @ending_coordinate[1] > @starting_coordinate[1]
      'forwardAndUp'
    elsif @ending_coordinate[0] > @starting_coordinate[0]
      'forwardAndDown'
    elsif @ending_coordinate[1] > @starting_coordinate[1]
      'backAndUp'
    else
      'backAndDown'
    end
  end

  def calculate_absolute_distance(starting_coordinate, ending_coordinate)
    (ending_coordinate - starting_coordinate).abs
  end

  def calculate_midpoint
    x_midpoint = 0
    y_midpoint = 0
    if @ending_coordinate[0] > @starting_coordinate[0]
      x_midpoint = @starting_coordinate[0] + @horizontal_half
    else
      x_midpoint = @ending_coordinate[0] + @horizontal_half
    end
    if @ending_coordinate[1] > @starting_coordinate[1]
      y_midpoint = @starting_coordinate[1] + @vertical_half
    else
      y_midpoint = @ending_coordinate[1] + @vertical_half
    end
    @midpoint = [x_midpoint, y_midpoint]
  end

  def calculate_y(x)
    #Amplitude * Math.sin((2 * Math::PI / frequency) * ( x - horizontal_offset)) + vertical_offset
    @vertical_half * Math.sin((Math::PI / @horizontal_coordinate_difference) * (x - @midpoint[0])) + @midpoint[1]
  end

  def print_formula(x)
    p "#{@vertical_half} * sin((pi / #{@horizontal_coordinate_difference}) * (x - #{@midpoint[0]})) + #{@midpoint[1]}"
  end

  def get_all_frame_coordinates
    arr = []
    x_increment = (@ending_coordinate[0] - @starting_coordinate[0]).abs.to_f / @total_number_of_frames
    arr.push([@starting_frame, @starting_coordinate])
    case @direction
    when 'none'
      arr = no_movement(arr, x_increment)
    when 'forward'
      arr = forward(arr, x_increment)
    when 'back'
      arr = back(arr, x_increment)
    when 'up'
      @horizontal_coordinate_difference = TEN
      @midpoint[0] = FIVE
      x_increment = 1
      arr = up(arr, x_increment)
    when 'down'
      @horizontal_coordinate_difference = TEN
      @midpoint[0] = FIVE
      x_increment = 1
      arr = down(arr, x_increment)
    when 'forwardAndUp'
      arr = forward_and_up(arr, x_increment)
    when 'forwardAndDown'
      arr = forward_and_down(arr, x_increment)
    when 'backAndUp'
      arr = back_and_up(arr, x_increment)
    else
      arr = back_and_down(arr, x_increment)
    end
    arr.push([@ending_frame, @ending_coordinate])
  end

  def no_movement(initial_arr, x_increment)
    frame_arr = get_in_between_frames
    x_arr = get_x_coordinates(@starting_coordinate[0], x_increment)
    y_arr = get_y_coordinates(x_arr)
    zip_combine_concat(initial_arr, frame_arr, x_arr, y_arr)
  end

  def forward(initial_arr, x_increment)
    frame_arr = get_in_between_frames
    x_arr = get_x_coordinates(@starting_coordinate[0] + x_increment, x_increment)
    y_arr = get_y_coordinates(x_arr)
    zip_combine_concat(initial_arr, frame_arr, x_arr, y_arr)
  end

  def back(initial_arr, x_increment)
    frame_arr = get_in_between_frames
    x_arr = get_x_coordinates(@starting_coordinate[0] - x_increment, x_increment)
    y_arr = get_y_coordinates(x_arr)
    zip_combine_concat(initial_arr, frame_arr, x_arr, y_arr)
  end

  def up(initial_arr, x_increment)
    frame_arr = get_in_between_frames
    x_arr = get_x_coordinates(0 + x_increment, x_increment)
    y_arr = get_y_coordinates(x_arr)
    zip_combine_concat(initial_arr, frame_arr, x_arr, y_arr)
  end

  def down(initial_arr, x_increment)
    frame_arr = get_in_between_frames
    x_arr = get_x_coordinates(0 + x_increment, x_increment)
    y_arr = get_y_coordinates(x_arr)
    zip_combine_concat(initial_arr, frame_arr, x_arr, y_arr.reverse)
  end

  def forward_and_up(initial_arr, x_increment)
    frame_arr = get_in_between_frames
    x_arr = get_x_coordinates(@starting_coordinate[0] + x_increment, x_increment)
    y_arr = get_y_coordinates(x_arr)
    zip_combine_concat(initial_arr, frame_arr, x_arr, y_arr)
  end

  def forward_and_down(initial_arr, x_increment)
    frame_arr = get_in_between_frames
    x_arr = get_x_coordinates(@starting_coordinate[0] + x_increment, x_increment)
    y_arr = get_y_coordinates(x_arr)
    zip_combine_concat(initial_arr, frame_arr, x_arr, y_arr.reverse)
  end

  def back_and_up(initial_arr, x_increment)
    frame_arr = get_in_between_frames
    x_arr = get_x_coordinates(@starting_coordinate[0] - x_increment, x_increment)
    y_arr = get_y_coordinates(x_arr)
    zip_combine_concat(initial_arr, frame_arr, x_arr, y_arr.reverse)
  end

  def back_and_down(initial_arr, x_increment)
    frame_arr = get_in_between_frames
    x_arr = get_x_coordinates(@starting_coordinate[0] - x_increment, x_increment)
    y_arr = get_y_coordinates(x_arr)
    zip_combine_concat(initial_arr, frame_arr, x_arr, y_arr)
  end

  def zip_combine_concat(initial_arr, frame_arr, x_arr, y_arr)
    coordinate_arr = x_arr.zip(y_arr)
    combined_arr = frame_arr.zip(coordinate_arr)
    if @direction == 'down' || @direction == 'up'
      initial_arr.concat(combined_arr).each { |x| x[1][0] = @starting_coordinate[0] }
    else
      initial_arr.concat(combined_arr)
    end
  end

  def get_y_coordinates(x_arr)
    y_arr = []
    if @direction == 'none' || @direction == 'forward' || @direction == 'back'
      x_arr.each do
        y_arr.push(@starting_coordinate[1])
      end
    else
      x_arr.each do |x|
        y_arr.push(calculate_y(x))
      end
    end
    y_arr
  end

  def get_x_coordinates(current_x_coordinate, x_increment)
    x_arr = []
    if @direction == 'none'
      ((@starting_frame + 1)..(@ending_frame - 1)).each do
        x_arr.push(current_x_coordinate)
      end
    elsif @direction == 'up' || @direction == 'down' || @direction.include?('forward')
      ((@starting_frame + 1)..(@ending_frame - 1)).each do
        x_arr.push(current_x_coordinate)
        current_x_coordinate += x_increment
      end
    else
      ((@starting_frame + 1)..(@ending_frame - 1)).each do
        x_arr.push(current_x_coordinate)
        current_x_coordinate -= x_increment
      end
    end
    x_arr
  end

  def get_in_between_frames
    frame_arr = []
    ((@starting_frame + 1)..(@ending_frame - 1)).each { |frame| frame_arr.push(frame) }
    frame_arr
  end
end
