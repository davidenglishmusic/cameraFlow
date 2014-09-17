require 'RMagick'
include Magick

require_relative 'lib/circleCoordinatesGen.rb'
require_relative 'lib/keyframeGen.rb'
require_relative 'lib/positionByFrameGen.rb'

class CameraFlow

  def initialize
    @currentImage = ImageList.new("green.jpg")
    @HDresolution = [1920, 1080]
    @amountInPixelsToEnlargeBy = 100.0
    @enlargementFactor = 1 + (@amountInPixelsToEnlargeBy / @HDresolution[0])
    @imageWidth = @currentImage.columns
    @imageHeight = @currentImage.rows
    @startingXPoint = @imageWidth * (@amountInPixelsToEnlargeBy / @HDresolution[0])
    @startingYPoint = @imageHeight * (@amountInPixelsToEnlargeBy / @HDresolution[0])
    @HDresolution = [1920, 1080]
  end

  def scaleCrop
    zoomedImage = @currentImage.scale(@enlargementFactor)
    croppedImage = zoomedImage.crop(@startingXPoint, @startingYPoint, @HDresolution[0], @HDresolution[1])
    croppedImage.write "green001.jpg"
  end

end

shake = CameraFlow.new()

shake.scaleCrop()
