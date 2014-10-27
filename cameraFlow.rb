require 'fileutils'
require 'RMagick'
include Magick

require_relative 'lib/flow.rb'

class CameraFlow

  attr_accessor :command
  attr_accessor :path
  attr_accessor :filename
  attr_accessor :extension
  attr_accessor :format
  attr_accessor :resolution
  attr_accessor :frame_total

  IMAGE_FORMATS = [".jpg", ".jpeg", ".gif", ".bmp", ".tif", ".png"]
  VIDEO_FORMATS = [".mov", ".mts", ".mp4", ".avi"]
  HELP_COMMAND =  'Please enter "ruby cameraFlow.rb h" for instructions.'

  def initialize()
    @command = ARGV[0]
    validate_command
    @path = ARGV[1]
    validate_file_exists
    get_filename_and_extension(@path)
    validate_extension
  end

  def validate_command
    if @command == "c"
      return
    elsif @command == "h"
      puts print_help_information
      exit
    else
      puts 'An invalid command has been entered.'
      exit
    end
  end

  def print_help_information
    puts ""
    puts "cameraFlow will accept the following file formats"
    print "Images: "
    IMAGE_FORMATS.each { |format | print format + " " }
    puts ""
    print "Videos: "
    VIDEO_FORMATS.each { |format | print format + " " }
    puts ""
    puts ""
    puts "Here are two sample commands: "
    puts "ruby cameraFlow.rb field.mov"
    puts "ruby cameraFlow.rb ~/Desktop/forest.png 300"
    puts "*If entering an image as opposed to a video, be sure to add the length in frames"
  end

  def get_filename_and_extension(path)
    filename_with_extension = File.split(path)[-1]
    @filename = /^\w+/.match(filename_with_extension).to_s
    @extension = /\.(.+)/.match(filename_with_extension).to_s
  end

  def validate_file_exists
    if File.exist? @path
      true
    else
      puts "File cannot be located - perhaps the path is incorrect."
      puts HELP_COMMAND
      exit
    end
  end

  def validate_extension
    if IMAGE_FORMATS.include? @extension
      @format = "image"
    elsif VIDEO_FORMATS.include? @extension
      @format = "video"
    else
      puts "The file has an extension that is not currently accepted."
      puts HELP_COMMAND
      exit
    end
  end

  def set_frame_total
    if @format == "image" && ARGV[2].to_i.class == Fixnum && ARGV[2].to_i > 0
      @frame_total = ARGV[2].to_i.round
    else
      @frame_total = Dir.entries("bench").size - 2
    end
  end

  def prepare_bench
    if @format == "image"
      FileUtils.cp "#{@path}", "bench/#{@filename}#{@extension}"
    else
      `avconv -i #{@path} -vsync 1 -r 24 -an -y -qscale 1 bench/%d.png`
    end
  end

  def tear_down_bench
    FileUtils.rm_r Dir.glob('bench/*')
  end

  def set_resolution
    image = ImageList.new(Dir.glob('bench/*').first(1)[0])
    @resolution = [image.columns, image.rows]
  end

  def start_flow
    flow = Flow.new(@filename, @extension, @resolution[0])
    flow.total_frames_of_clip = @frame_total
    flow.set_number_of_keyframes(@frame_total)
    keyframes_and_coordinates = flow.combine_keyframes_with_their_coordinates(flow.get_circle_coordinates, flow.get_keyframes)
    all_frames_and_coordinates = flow.get_all_frames_and_coordinates(keyframes_and_coordinates)
    flow.creates_frames_from_sequence(all_frames_and_coordinates)
  end

end

# Command Sequence

cameraFlow = CameraFlow.new

cameraFlow.prepare_bench

cameraFlow.set_resolution

cameraFlow.set_frame_total

cameraFlow.start_flow

cameraFlow.tear_down_bench
