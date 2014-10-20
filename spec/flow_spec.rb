require_relative '../lib/flow'

describe Flow do

  before :all do
    @test_object_001 = Flow.new("green",".jpg",1080)
  end

  describe "calculate_absolute_distance" do
    it "returns the filename when the filename is called" do
      expect(@test_object_001.filename).to eq("green")
    end
  end

end
