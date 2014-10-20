require 'RMagick'
include Magick

require_relative 'circleCoordinatesGen.rb'
require_relative 'keyframeGen.rb'
require_relative 'positionByFrameGen.rb'

class Flow

  Ten_percent = 0.1

  attr_accessor :HD_resolution
  attr_accessor :enlargement_factor_in_pixels
  attr_accessor :current_image
  attr_accessor :enlargement_factor
  attr_accessor :image_width
  attr_accessor :image_height
  attr_accessor :starting_x_point
  attr_accessor :starting_y_point
  attr_accessor :total_frames_of_clip
  attr_accessor :number_of_keyframes
  attr_accessor :starting_coordinates
  attr_accessor :ending_coordinates
  attr_accessor :limit
  attr_accessor :filename
  attr_accessor :extension
  attr_accessor :proximity_minimum

  def set_HD_resolution(value)
    if value == 1080
      @HD_resolution = [1920, 1080]
    else
      @HD_resolution = [1280, 720]
    end
  end

  def initialize(filename, extension, resolution)
    @filename = filename
    @extension = extension
    @current_image = ImageList.new(@filename + @extension)
    set_HD_resolution(resolution)
    @enlargement_factor_in_pixels = 100
    @enlargement_factor = 1 + (@enlargement_factor_in_pixels / @HD_resolution[0])
    @image_width = @current_image.columns
    @image_height = @current_image.rows
    @starting_x_point = @image_width * (@enlargement_factor_in_pixels / @HD_resolution[0])
    @starting_y_point = @image_height * (@enlargement_factor_in_pixels / @HD_resolution[1])
    @total_frames_of_clip = 60
    @number_of_keyframes = (@total_frames_of_clip * Ten_percent).round
    @starting_coordinates = [0,0]
    @ending_coordinates = [0,0]
    @limit = 5
    @proximity_minimum = 5
    puts "File selected: " + @filename + @extension
    puts "Total frames to generate: " + @total_frames_of_clip.to_s
    puts "Key frames to generate: " + @number_of_keyframes.to_s
    puts "Enumerated file to be created: " + @filename + "####" + @extension
    puts "Resolution Selected: " + @HDresolution.to_s
  end

  def scale_crop(coordinates, filename)
    zoomed_image = @current_image.scale(@enlargement_factor)
    cropped_image = zoomed_image.crop(@starting_x_point + coordinates[0], @starting_y_point + coordinates[1], @HD_resolution[0], @HD_resolution[1])
    cropped_image.write "#{filename}"
  end

  def get_circle_coordinates
    p @limit
    CircleCoordinatesGen.new(@number_of_keyframes, @limit).generate_coordinates()
  end

  def get_keyframes
    KeyframeGen.new(@number_of_keyframes, @total_frames_of_clip, @proximity_minimum).generate_keyframes()
  end

  def get_keyframes_and_coordinates(circle_coordinates, keyframes)
    keyframes_and_coordinates = keyframes.zip(circle_coordinates)
    keyframes_and_coordinates.insert(0, [0, @starting_coordinates])
    keyframes_and_coordinates.push([@total_frames_of_clip, @ending_coordinates])
  end

  def get_all_frames_and_coordinates(key_frames_and_coordinates)
    arr = []
    final_arr = []
    key_frames_and_coordinates.each_cons(2) do | frame_and_coordinate_A, frame_and_coordinate_B |
      frames_for_this_keyframe_pair = PositionByFrameGen.new(frame_and_coordinate_A[1], frame_and_coordinate_B[1], frame_and_coordinate_A[0], frame_and_coordinate_B[0]).get_all_frame_coordinates()
      frames_for_this_keyframe_pair.pop
      arr.concat(frames_for_this_keyframe_pair)
    end
    arr.compact.flatten.each_slice(3).to_a
    arr
  end

end
