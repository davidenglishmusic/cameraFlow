class PositionByFrameGen

  def initialize(startingCoordinate, endingCoordinate, startingFrame, endingFrame)
    @TWO = 2
    @startingCoordinate = startingCoordinate
    @endingCoordinate = endingCoordinate
    @startingFrame = startingFrame
    @endingFrame = endingFrame
    @horizontalCoordinateDifference = (@startingCoordinate[0]).abs + (@endingCoordinate[0]).abs
    @horizontalHalf = @horizontalCoordinateDifference / @TWO
    @verticalCoordinateDifference = (@startingCoordinate[1]).abs + (@endingCoordinate[1]).abs
    @verticalHalf = @verticalCoordinateDifference / @TWO
    @midpoint = calculateMidpoint()
    @totalNumberOfFrames = @endingFrame - @startingFrame
  end

  def calculateMidpoint()
    xMidpoint = 0
    yMidpoint = 0
    if @startingCoordinate[0] > @endingCoordinate[0]
      xMidpoint = @startingCoordinate[0] - @horizontalHalf
    else
      xMidpoint = @endingCoordinate[0] - @horizontalHalf
    end
    if @startingCoordinate[1] > @endingCoordinate[1]
      yMidpoint = @startingCoordinate[1] - @verticalHalf
    else
      yMidpoint = @endingCoordinate[0] - @verticalHalf
    end
    [xMidpoint, yMidpoint]
  end

  def calculateY(x)
    #Amplitude * Math.sin((2 * Math::PI / Frequency) * ( x - horizontalOffset)) + verticalOffset
    @verticalHalf * Math.sin((Math::PI / @horizontalCoordinateDifference) * (x - @midpoint[0])) + @midpoint[1]
  end

  def getAllFrameCoordinates()
    arr = []
    xIncrement = (@endingCoordinate[0] - @startingCoordinate[0].abs).to_f/@totalNumberOfFrames
    currentXCoordinate = @startingCoordinate[0]
    arr.push([@startingFrame, @startingCoordinate])
    ((@startingFrame + 1)..(@endingFrame - 1)).each do |frame|
      currentXCoordinate += xIncrement
      newCoordinate = [currentXCoordinate, calculateY(currentXCoordinate)]
      arr.push([frame, newCoordinate])
    end
    arr.push([@endingFrame, @endingCoordinate])
  end

end
