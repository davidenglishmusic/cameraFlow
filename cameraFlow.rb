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
    @startingYPoint = @imageHeight * (@amountInPixelsToEnlargeBy / @HDresolution[1])
    @numberOfKeyFrames = 2
    @totalFramesOfClip = 30
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

  def getCircleCoordinates
    CircleCoordinatesGen.new(@numberOfKeyFrames, @limit).generateCoordinates()
  end

  def getkeyFrames
    KeyframeGen.new(@numberOfKeyFrames, @totalFramesOfClip).generateKeyframes()
  end

  def getKeyFramesAndCoordinates(circleCoordinates, keyFrames)
    keyFramesandCoordinates = keyFrames.zip(circleCoordinates)
    keyFramesandCoordinates.insert(0, [0, @startingCoordinates])
    keyFramesandCoordinates.push([@totalFramesOfClip, @endingCoordinates])
  end

  def getAllFramesAndCoordinates(keyFramesAndCoordinates)
    arr = []
    finalArr = []
    keyFramesAndCoordinates.each_cons(2) do | frameAndCoordinateA, frameAndCoordinateB |
      framesForThisKeyFramePair = PositionByFrameGen.new(frameAndCoordinateA[1], frameAndCoordinateB[1], frameAndCoordinateA[0], frameAndCoordinateB[0]).getAllFrameCoordinates()
      framesForThisKeyFramePair.pop
      arr.concat(framesForThisKeyFramePair)
    end
    arr.compact.flatten.each_slice(3).to_a
    arr
  end

end

# shake = CameraFlow.new()
#
# p shake.getAllFramesAndCoordinates(shake.getKeyFramesAndCoordinates(shake.getCircleCoordinates(), shake.getkeyFrames))
