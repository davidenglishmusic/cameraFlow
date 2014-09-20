class PositionByFrameGen

  attr_accessor :direction
  attr_accessor :horizontalCoordinateDifference
  attr_accessor :verticalCoordinateDifference

  def initialize(startingCoordinate, endingCoordinate, startingFrame, endingFrame)
    @TWO = 2
    @startingCoordinate = startingCoordinate
    @endingCoordinate = endingCoordinate
    @startingFrame = startingFrame
    @endingFrame = endingFrame
    @horizontalCoordinateDifference = (@endingCoordinate[0]) - (@startingCoordinate[0]).abs
    @horizontalHalf = @horizontalCoordinateDifference / @TWO
    @verticalCoordinateDifference = (@endingCoordinate[1] - @startingCoordinate[1]).abs
    @verticalHalf = @verticalCoordinateDifference / @TWO
    @midpoint = calculateMidpoint()
    @totalNumberOfFrames = @endingFrame - @startingFrame
    @direction = determineDirection()
  end

  def determineDirection
    if @endingCoordinate[0] > @startingCoordinate[0] && @endingCoordinate[1] > @startingCoordinate[1]
      "forwardAndUp"
    elsif @endingCoordinate[0] > @startingCoordinate[0]
      "forwardAndDown"
    elsif @endingCoordinate[1] > @startingCoordinate[1]
      "backAndUp"
    else
      "backAndDown"
    end
  end

  def calculateMidpoint()
    xMidpoint = 0
    yMidpoint = 0
    if @startingCoordinate[0] > @endingCoordinate[0]
      xMidpoint = @endingCoordinate[0] - @horizontalHalf
    else
      xMidpoint = @endingCoordinate[0] - @horizontalHalf
    end
    if @startingCoordinate[1] > @endingCoordinate[1]
      yMidpoint = @startingCoordinate[1] - @verticalHalf
    else
      yMidpoint = @endingCoordinate[1] - @verticalHalf
    end
    [xMidpoint, yMidpoint]
  end

  def calculateY(x)
    #Amplitude * Math.sin((2 * Math::PI / Frequency) * ( x - horizontalOffset)) + verticalOffset
    @verticalHalf * Math.sin((Math::PI / @horizontalCoordinateDifference) * (x - @midpoint[0])) + @midpoint[1]
  end

  def printFormula()
    p "#{@verticalHalf} * sin((pi / #{@horizontalCoordinateDifference}) * (x - #{@midpoint[0]})) + #{@midpoint[1]}"
  end

  def getAllFrameCoordinates()
    arr = []
    xIncrement = (@endingCoordinate[0] - @startingCoordinate[0].abs).to_f/@totalNumberOfFrames
    currentXCoordinate = @startingCoordinate[0]
    arr.push([@startingFrame, @startingCoordinate])
    case @direction
    when "forwardAndUp"
      arr = forwardAndUp(arr, xIncrement)
    when "forwardAndDown"
      arr = (forwardAndDown(arr, xIncrement))
    when "backAndUp"
      arr = backAndUp(arr, xIncrement)
    else
      arr = backAndDown(arr, xIncrement)
    end
    arr.push([@endingFrame, @endingCoordinate])
  end

  def forwardAndUp(initialArr, xIncrement)
    frameArr = []
    xArr = []
    yArr = []
    currentXCoordinate = @startingCoordinate[0] + xIncrement
    ((@startingFrame + 1)..(@endingFrame - 1)).each do |frame|
      frameArr.push(frame)
      xArr.push(currentXCoordinate)
      currentXCoordinate += xIncrement
    end
    xArr.each do |x|
      yArr.push(calculateY(x))
    end
    coordinateArr = xArr.zip(yArr)
    combinedArr = frameArr.zip(coordinateArr)
    initialArr.concat(combinedArr)
  end

  def forwardAndDown(initialArr, xIncrement)
    frameArr = []
    xArr = []
    yArr = []
    currentXCoordinate = @startingCoordinate[0] + xIncrement
    ((@startingFrame + 1)..(@endingFrame - 1)).each do |frame|
      frameArr.push(frame)
      xArr.push(currentXCoordinate)
      currentXCoordinate += xIncrement
    end
    xArr.each do |x|
      yArr.push(calculateY(x))
    end
    coordinateArr = xArr.zip(yArr.reverse)
    combinedArr = frameArr.zip(coordinateArr)
    initialArr.concat(combinedArr)
  end

  def backAndUp(initialArr, xIncrement)
    frameArr = []
    xArr = []
    yArr = []
    currentXCoordinate = @startingCoordinate[0] + xIncrement
    ((@startingFrame + 1)..(@endingFrame - 1)).each do |frame|
      frameArr.push(frame)
      xArr.push(currentXCoordinate)
      currentXCoordinate += xIncrement
    end
    xArr.each do |x|
      yArr.push(calculateY(x))
    end
    coordinateArr = xArr.zip(yArr)
    combinedArr = frameArr.zip(coordinateArr)
    initialArr.concat(combinedArr)
  end

  def backAndDown(initialArr, xIncrement)
    frameArr = []
    xArr = []
    yArr = []
    currentXCoordinate = @startingCoordinate[0] + xIncrement
    ((@startingFrame + 1)..(@endingFrame - 1)).each do |frame|
      frameArr.push(frame)
      xArr.push(currentXCoordinate)
      currentXCoordinate += xIncrement
    end
    xArr.each do |x|
      yArr.push(calculateY(x))
    end
    coordinateArr = xArr.zip(yArr.reverse)
    combinedArr = frameArr.zip(coordinateArr)
    initialArr.concat(combinedArr)
  end

end
