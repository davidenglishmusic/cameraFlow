require 'RMagick'
include Magick

class Dark_room

  TWO = 2

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
    starting_x_point = ((image.columns * @enlargement_factor) - image.columns) / TWO + coordinates[0]
    starting_y_point = ((image.rows * @enlargement_factor) - image.rows) / TWO + coordinates[1]
    scaled_image = image.scale(@enlargement_factor)
    adjusted_image = get_subpixel_crop(scaled_image, 0 + coordinates[0], 0 + coordinates[1], @HD_width + coordinates[0], @HD_height + coordinates[1])
    adjusted_image.write "output/#{filename + count.to_s + '.png'}"
    adjusted_image.destroy!
  end

  def get_subpixel_crop(image, left, top, right, bottom)
    final_width = @HD_width
    final_height = @HD_height
    distance_to_centre_x = 0.5 * (left.abs + right.abs)
    distance_to_centre_y = 0.5 * (top.abs + bottom.abs)
    scale_x = 1.0
    scale_y = 1.0
    image.distort( Magick::ScaleRotateTranslateDistortion, [distance_to_centre_x, distance_to_centre_y, scale_x, scale_y, 0.0, 0.5 * final_width, 0.5 * final_height] ) do |i|
      i.define("distort:viewport", "#{final_width}x#{final_height}+0+0")
    end
  end

end
