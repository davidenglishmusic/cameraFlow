require 'RMagick'
include Magick

class DarkRoom
  TWO = 2
  POINT_FIVE = 0.5
  SCALE_X = 1.0
  SCALE_Y = 1.0

  attr_accessor :enlargement_factor
  attr_accessor :HD_width
  attr_accessor :HD_height

  def initialize(enlargement_factor, resolution)
    @enlargement_factor = enlargement_factor
    @HD_width = resolution[0]
    @HD_height = resolution[1]
  end

  def process_image(file_path, filename, extension, coordinates, count)
    image = ImageList.new(file_path)
    scaled_image = image.scale(@enlargement_factor)
    distortion_settings = create_distortion_settings(0 + coordinates[0], 0 + coordinates[1], @HD_width + coordinates[0], @HD_height + coordinates[1])
    p distortion_settings
    adjusted_image = distort_image(scaled_image, distortion_settings[:distance_to_centre_x], distortion_settings[:distance_to_centre_y], distortion_settings[:final_width], distortion_settings[:final_height])
    adjusted_image.write "output/#{filename + count.to_s + '.png'}"
    adjusted_image.destroy!
  end

  def create_distortion_settings(left, top, right, bottom)
    {:final_width => @HD_width, :final_height => @HD_height, :distance_to_centre_x => distance_to_centre(left, right), :distance_to_centre_y => distance_to_centre(top, bottom)}
  end

  def distort_image(image, distance_to_centre_x, distance_to_centre_y, final_width, final_height)
    image.distort(Magick::ScaleRotateTranslateDistortion, [distance_to_centre_x, distance_to_centre_y, SCALE_X, SCALE_Y, 0.0, POINT_FIVE * final_width, POINT_FIVE * final_height]) do |i|
      i.define('distort:viewport', "#{final_width}x#{final_height}+0+0")
    end
  end

  def distance_to_centre(sideA, sideB)
    POINT_FIVE * (sideA.abs + sideB.abs)
  end
end
