require_relative 'circleCoordinatesGen.rb'
require_relative 'keyframeGen.rb'
require_relative 'positionByFrameGen.rb'
require_relative 'darkRoom.rb'

class Flow

  Ten_percent = 0.1

  attr_accessor :HD_resolution
  attr_accessor :enlargement_factor_in_pixels
  attr_accessor :current_image
  attr_accessor :enlargement_factor
  attr_accessor :total_frames_of_clip
  attr_accessor :number_of_keyframes
  attr_accessor :starting_coordinates
  attr_accessor :ending_coordinates
  attr_accessor :limit
  attr_accessor :filename
  attr_accessor :extension
  attr_accessor :proximity_minimum

  def initialize(filename, extension, resolution)
    @filename = filename
    @extension = extension
    set_HD_resolution(resolution)
    @enlargement_factor_in_pixels = 100.0
    @enlargement_factor = 1 + (@enlargement_factor_in_pixels / @HD_resolution[0])
    @total_frames_of_clip = 60
    set_number_of_keyframes(@total_frames_of_clip)
    @starting_coordinates = [0,0]
    @ending_coordinates = [0,0]
    @limit = 5
    @proximity_minimum = 5
  end

  def set_HD_resolution(value)
    if value == 1080
      @HD_resolution = [1920, 1080]
    else
      @HD_resolution = [1280, 720]
    end
  end

  def set_number_of_keyframes(total_frames_of_clip)
    @number_of_keyframes = (@total_frames_of_clip * Ten_percent).round
  end

  def get_circle_coordinates
    CircleCoordinatesGen.new(@number_of_keyframes, @limit).generate_coordinates()
  end

  def get_keyframes
    KeyframeGen.new(@number_of_keyframes, @total_frames_of_clip, @proximity_minimum).generate_keyframes()
  end

  def combine_keyframes_with_their_coordinates(circle_coordinates, keyframes)
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

  def creates_frames_from_single(frames_and_coordinates)
    count = 0
    frames_and_coordinates.each do |i|
      create_new_frame('bench/'+ @filename + @extension, @filename, @extension, i[1], count)
      count = count + 1
      p count.to_s + " of " + @total_frames_of_clip.to_s
    end
  end

  def create_new_frame(file_path, filename, extension, coordinates, count)
    dark_room = Dark_room.new(@enlargement_factor, @HD_resolution)
    dark_room.process_image(file_path, filename, extension, coordinates, count)
  end

  def creates_frames_from_sequence(frames_and_coordinates)
    count = 0
    bench_directory = Dir.entries('bench').sort_by { |a| File.stat('bench/' + a).mtime }
    bench_directory.each do |item|
      next if item == '.' or item == '..'
      create_new_frame("bench/" + item, @filename, @extension, frames_and_coordinates[count][1], count)
      p frames_and_coordinates[count][1]
      count = count + 1
      p count.to_s + " of " + @total_frames_of_clip.to_s
    end
  end

end
