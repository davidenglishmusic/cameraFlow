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
  attr_accessor :error_message

  IMAGE_FORMATS = ['.jpg', '.jpeg', '.gif', '.bmp', '.tif', '.png']
  VIDEO_FORMATS = ['.mov', '.mts', '.mp4', '.avi']
  HELP_COMMAND =  'Please enter "ruby cameraFlow.rb h" for instructions.'

  def initialize(command, path)
    @command = command
    @path = path
  end

  def run_validations
    if !valid_command?
      puts 'An invalid command has been entered. ' << HELP_COMMAND
      exit
    end
    if need_help?
      puts help_information
      exit
    end
    if File.exist? @path
      puts 'found'
    else
      puts '?'
    end
    if !File.exist? @path
      puts 'File cannot be located - perhaps the path is incorrect. ' << HELP_COMMAND
      exit
    end
    parse_filename_and_extension
    if !valid_extension?
      puts 'The file has an extension that is not currently accepted.'
      puts HELP_COMMAND
      exit
    end
  end

  def valid_command?
    if @command == 'c' || @command == 'h'
      true
    else
      false
    end
  end

  def need_help?
    if @command == 'h'
      true
    else
      false
    end
  end

  def valid_extension?
    if IMAGE_FORMATS.include? @extension
      @format = 'image'
      true
    elsif VIDEO_FORMATS.include? @extension
      @format = 'video'
      true
    else
      false
    end
  end

  def help_information
    "
      cameraFlow will accept the following file formats:
      Images:
      #{IMAGE_FORMATS.each { |format | format + ' ' }}
      Videos:
      #{VIDEO_FORMATS.each { |format | format + ' ' }}
      Here are two sample commands:
      ruby cameraFlow.rb field.mov
      ruby cameraFlow.rb ~/Desktop/forest.png 300
      *If entering an image as opposed to a video, be sure to add the length in frames"
  end

  def parse_filename_and_extension
    filename_with_extension = File.split(@path)[-1]
    @filename = /^\w+/.match(filename_with_extension).to_s
    @extension = /\.(.+)/.match(filename_with_extension).to_s
  end

  def set_frame_total
    if @format == 'image' && ARGV[2].to_i.class == Fixnum && ARGV[2].to_i > 0
      @frame_total = ARGV[2].to_i.round
    else
      @frame_total = Dir.entries('bench').size - 2
    end
  end

  def prepare_bench
    tear_down_bench if File.directory? 'bench'
    FileUtils.mkdir 'bench'
    if @format == 'image'
      FileUtils.cp "#{@path}", "bench/#{@filename}#{@extension}"
    else
      `avconv -i #{@path} -vsync 1 -r 24 -an -y -qscale 1 bench/%d.png`
    end
  end

  def tear_down_bench
    FileUtils.rm_r Dir.glob('bench/*')
    FileUtils.rmdir 'bench'
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
    if @format == 'image'
      flow.creates_frames_from_single(all_frames_and_coordinates)
    else
      flow.creates_frames_from_sequence(all_frames_and_coordinates)
    end
  end

end

# Command Sequence

camera_flow = CameraFlow.new(ARGV[0], ARGV[1])

camera_flow.run_validations

camera_flow.prepare_bench

camera_flow.set_resolution

camera_flow.set_frame_total

camera_flow.start_flow

puts 'Flow complete'
puts 'Tearing down the bench'
camera_flow.tear_down_bench

puts 'Please check the output folder'
