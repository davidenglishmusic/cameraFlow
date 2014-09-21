class KeyframeGen

  def initialize(numberOfKeyframesToGenerate, totalFramesOfClip)
    @numberOfKeyframesToGenerate = numberOfKeyframesToGenerate
    @totalFramesOfClip = totalFramesOfClip
    @proximityMinimum = 5
  end

  def generateKeyframes()
    arr = []
    (0..@numberOfKeyframesToGenerate).each do
      proximityAndUniquenessCondition = false
      while !proximityAndUniquenessCondition do
        newFrame = generateFrame()
        if isUnique(newFrame, arr) && !isTooClose(newFrame, arr)
          arr.push(newFrame)
          proximityAndUniquenessCondition = true
        end
      end
    end
    arr.sort
  end

  def generateFrame()
    rand(0..@totalFramesOfClip)
  end

  def isUnique(newFrame, arr)
    return true if arr.index(newFrame) == nil && newFrame > @proximityMinimum && newFrame < (@totalFramesOfClip - @proximityMinimum)
    false
  end

  def isTooClose(newFrame, arr)
    return false if arr.empty?
    arr.each do |previousFrame|
      if ((newFrame - previousFrame).abs < @proximityMinimum && (previousFrame - newFrame).abs < @proximityMinimum)
        return true
      end
    end
    false
  end

end
