class KeyframeGen
  BUFFER_ZONE = 3

  attr_accessor :number_of_keyframes_to_generate
  attr_accessor :total_frames_of_clip
  attr_accessor :proximity_minimum

  def initialize(number_of_keyframes_to_generate, total_frames_of_clip, proximity_minimum)
    @number_of_keyframes_to_generate = number_of_keyframes_to_generate
    @total_frames_of_clip = total_frames_of_clip
    @proximity_minimum = proximity_minimum
  end

  def possible_to_calculate?
    if @total_frames_of_clip / @proximity_minimum <= @number_of_keyframes_to_generate
      true
    else
      false
    end
  end

  def easy_to_calculate?
    if @number_of_keyframes_to_generate < (@total_frames_of_clip / @proximity_minimum) - BUFFER_ZONE
      true
    else
      false
    end
  end

  def generate_keyframes
    arr = []
    (0..@number_of_keyframes_to_generate).each do
      arr.push(generate_frame(arr))
    end
    arr.sort
  end

  def generate_frame(arr)
    uniqueness_unknown = true
    new_frame = 0
    while uniqueness_unknown
      new_frame = rand(0..@total_frames_of_clip)
      if unique?(new_frame, arr) && !too_close?(new_frame, arr)
        uniqueness_unknown = false
      end
    end
    new_frame
  end

  def unique?(new_frame, arr)
    return true if arr.index(new_frame).nil? && new_frame > @proximity_minimum && new_frame < (@total_frames_of_clip - @proximity_minimum)
    false
  end

  def too_close?(new_frame, arr)
    return false if arr.empty?
    arr.each do |previous_frame|
      if (new_frame - previous_frame).abs <= @proximity_minimum && (previous_frame - new_frame).abs <= @proximity_minimum
        return true
      end
    end
    false
  end
end
