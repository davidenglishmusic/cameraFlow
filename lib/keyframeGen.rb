class KeyframeGen

  attr_accessor :number_of_keyframes_to_generate
  attr_accessor :total_frame_of_clip
  attr_accessor :proximity_minimum

  def initialize(number_of_keyframes_to_generate, total_frames_of_clip, proximity_minimum)
    @number_of_keyframes_to_generate = number_of_keyframes_to_generate
    @total_frames_of_clip = total_frames_of_clip
    @proximity_minimum = proximity_minimum
  end

  def generate_keyframes()
    arr = []
    (0..@number_of_keyframes_to_generate).each do
      proximity_and_uniqueness_condition = false
      while !proximity_and_uniqueness_condition do
        new_frame = generate_frame()
        if is_unique(new_frame, arr) && !is_too_close(new_frame, arr)
          arr.push(new_frame)
          proximity_and_uniqueness_condition = true
        end
      end
    end
    arr.sort
  end

  def generate_frame()
    rand(0..@total_frames_of_clip)
  end

  def is_unique(new_frame, arr)
    return true if arr.index(new_frame) == nil && new_frame > @proximity_minimum && new_frame < (@total_frames_of_clip - @proximity_minimum)
    false
  end

  def is_too_close(new_frame, arr)
    return false if arr.empty?
    arr.each do |previous_frame|
      if ((new_frame - previous_frame).abs < @proximity_minimum && (previous_frame - new_frame).abs < @proximity_minimum)
        return true
      end
    end
    false
  end

end
