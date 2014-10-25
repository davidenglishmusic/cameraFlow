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
    image_width = image.columns
    image_height = image.rows
    starting_x_point = ((image_width * @enlargement_factor) - image_width) / TWO + coordinates[0]
    starting_y_point = ((image_height * @enlargement_factor) - image_height) / TWO + coordinates[1]
    scaled_image = image.scale(@enlargement_factor)
    hd_width = @HD_width
    hd_height = @HD_height
    adjusted_image = scaled_image.distort(Magick::ScaleRotateTranslateDistortion, [0]) do
        self.define "distort:viewport", "#{hd_width}x#{hd_height}+#{starting_x_point}+#{starting_y_point}"
    end
    adjusted_image.write "output/#{filename + count.to_s + extension}"
    adjusted_image.destroy!
  end

end
