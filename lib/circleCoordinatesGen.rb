class CircleCoordinatesGen

  def initialize(numberOfCoordinatesToGenerate, limit)
    @numberOfCoordinatesToGenerate = numberOfCoordinatesToGenerate
    @limit = limit
    @TWO = 2
  end

  def generateCoordinates()
    arr = []
    (0..@numberOfCoordinatesToGenerate).each do
      radiusCondition = false
      while !radiusCondition do
        x = generateCoordinate()
        y = generateCoordinate()
        if calculateRadius(x,y) <= @limit
          radiusCondition = true
        end
      end
      arr.push([x,y])
    end
    arr
  end

  def generateCoordinate()
    rand((-@limit)..@limit)
  end

  def calculateRadius(x,y)
    Math.sqrt(x.abs ** @TWO + y.abs ** @TWO)
  end

end
