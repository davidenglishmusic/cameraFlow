require_relative 'lib/flow.rb'

class CameraFlow

  attr_accessor :filename
  attr_accessor :extension
  attr_accessor :resolution

  def initialize()
    @filename = /^\w+/.match(ARGV[0]).to_s
    @extension = /\.(.+)/.match(ARGV[0]).to_s
    @resolution = ARGV[1]
  end

  def startFlow()
    puts "File selected: " + @filename + @extension
    puts "Total frames to generate: "
    puts "Key frames to generate: "
    puts "Enumerated file to be created: " + @filename + "####" + @extension
    puts "Resolution Selected: " + @resolution
    flow = Flow.new(@filename, @extension, @resolution)
  end

end

#shake = CameraFlow.new()

#p shake.get_all_frames_and_coordinates(shake.get_keyframes_and_coordinates(shake.get_circle_coordinates(), shake.get_keyframes))
