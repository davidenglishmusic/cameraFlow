require_relative '../lib/darkRoom'

describe DarkRoom do

  before :all do
    @test_object_001 = DarkRoom.new(1.052083333, [1920,1080])
  end

  describe 'distance_to_centre' do
    it 'returns the distance to the center from the sides' do
      expect(@test_object_001.distance_to_centre(0, 1920)).to eq(960)
    end
  end

end
