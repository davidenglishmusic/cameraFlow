require 'RMagick'
include Magick

class Dark_room

  def initialize(enlargement_factor, resolution)
    @enlargement_factor = enlargement_factor
    @HD_resolution = resolution
  end

  def process_image(filename, extension, coordinates, count)
    image = ImageList.new(filename + extension)
    scaled_image = image.scale(@enlargement_factor)
    scaled_image_width = scaled_image.columns
    scaled_image_height = scaled_image.rows
    starting_x_point = scaled_image_width * (@enlargement_factor / @HD_resolution[0]) + coordinates[0]
    starting_y_point = scaled_image_width * (@enlargement_factor / @HD_resolution[1]) + coordinates[1]
    cropped_image = scaled_image.crop(starting_x_point, starting_y_point, @HD_resolution[0], @HD_resolution[1])
    cropped_image.write "output/#{filename + count.to_s + extension}"
  end

end
