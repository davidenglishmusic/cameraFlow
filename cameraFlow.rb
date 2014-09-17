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
    @numberOfKeyFrames = 20
    @totalFramesOfClip = 300
    @startingCoordinates = [0,0]
    @endingCoordinates = [0,0]
    @limit = @startingYPoint
    @filename = "green"
    @extension = ".jpg"
  end

  def scaleCrop(coordinates, filename)
    zoomedImage = @currentImage.scale(@enlargementFactor)
    croppedImage = zoomedImage.crop(@startingXPoint + coordinates[0], @startingYPoint + coordinates[1], @HDresolution[0], @HDresolution[1])
    croppedImage.write "#{filename}"
  end

  def getKeyFramesAndCoordinates()
    circleCoordinates = CircleCoordinatesGen.new(@numberOfKeyFrames, @limit).generateCoordinates()
    keyFrames = KeyframeGen.new(@numberOfKeyFrames, @totalFramesOfClip).generateKeyframes()
    keyFramesandCoordinates = keyFrames.zip(circleCoordinates)
    keyFramesandCoordinates.insert(0, [0, @startingCoordinates])
    keyFramesandCoordinates.push([@totalFramesOfClip, [@endingCoordinates]])
  end

end

shake = CameraFlow.new()

p shake.getKeyFramesAndCoordinates()
