require_relative '../lib/flow'

describe Flow do

  before :all do
    @test_object_001 = Flow.new("green",".jpg", 1080)
    @test_object_002 = Flow.new("green",".jpg", 1080)
    @test_object_003 = Flow.new("field",".jpg", 1080)
  end

  describe "calculate_absolute_distance" do
    it "returns the filename when the filename is called" do
      expect(@test_object_001.filename).to eq("green")
    end
  end

  describe "combine_keyframes_with_their_coordinates" do
    it "returns an array with the keyframes combined with their generated coordinates" do
      circle_coordinates = [[2, -4], [1, 1], [-2, 0], [3, 2], [3, 3], [1, 3], [-4, 1]]
      keyframes = [9, 15, 20, 26, 35, 43, 48]
      expect(@test_object_001.combine_keyframes_with_their_coordinates(circle_coordinates, keyframes)).to eq([[0, [0, 0]], [9, [2, -4]], [15, [1, 1]], [20, [-2, 0]], [26, [3, 2]], [35, [3, 3]], [43, [1, 3]], [48, [-4, 1]], [60, [0, 0]]])
    end
  end

  describe "get_all_frames_and_coordinates" do
    it "returns all of the frames with their coordinates" do
      keyframes_and_coordinates = [[0, [0, 0]], [9, [2, -4]], [15, [1, 1]], [20, [-2, 0]], [26, [3, 2]], [35, [3, 3]], [43, [1, 3]], [48, [-4, 1]], [60, [0, 0]]]
      expect(@test_object_001.get_all_frames_and_coordinates(keyframes_and_coordinates)).to eq([[0, [0, 0]], [1, [0.2222222222222222, -0.12061475842818292]], [2, [0.4444444444444444, -0.46791111376204353]], [3, [0.6666666666666666, -0.9999999999999998]], [4, [0.8888888888888888, -1.6527036446661392]], [5, [1.1111111111111112, -2.347296355333861]], [6, [1.3333333333333335, -3.0]], [7, [1.5555555555555558, -3.532088886237956]], [8, [1.7777777777777781, -3.879385241571817]], [9, [2, -4]], [10, [1.8333333333333333, -3.665063509461098]], [11, [1.6666666666666665, -2.7500000000000018]], [12, [1.4999999999999998, -1.5000000000000018]], [13, [1.333333333333333, -0.2500000000000011]], [14, [1.1666666666666663, 0.6650635094610964]], [15, [1, 1]], [16, [0.4, 0.9045084971874737]], [17, [-0.19999999999999996, 0.6545084971874737]], [18, [-0.7999999999999999, 0.3454915028125264]], [19, [-1.4, 0.09549150281252633]], [20, [-2, 0]], [21, [-1.1666666666666665, 0.1339745962155614]], [22, [-0.33333333333333315, 0.5000000000000002]], [23, [0.5000000000000002, 1.0000000000000002]], [24, [1.3333333333333335, 1.5]], [25, [2.166666666666667, 1.8660254037844388]], [26, [3, 2]], [27, [3, 2.024471741852423]], [28, [3, 2.0954915028125263]], [29, [3, 2.2061073738537633]], [30, [3, 2.3454915028125263]], [31, [3, 2.5]], [32, [3, 2.6545084971874737]], [33, [3, 2.7938926261462367]], [34, [3, 2.9045084971874737]], [35, [3, 3]], [36, [2.75, 3]], [37, [2.5, 3]], [38, [2.25, 3]], [39, [2.0, 3]], [40, [1.75, 3]], [41, [1.5, 3]], [42, [1.25, 3]], [43, [1, 3]], [44, [0.0, 2.8090169943749475]], [45, [-1.0, 2.3090169943749475]], [46, [-2.0, 1.6909830056250525]], [47, [-3.0, 1.1909830056250525]], [48, [-4, 1]], [49, [-3.6666666666666665, 0.9829629131445341]], [50, [-3.333333333333333, 0.9330127018922194]], [51, [-2.9999999999999996, 0.8535533905932738]], [52, [-2.666666666666666, 0.7500000000000002]], [53, [-2.3333333333333326, 0.6294095225512606]], [54, [-1.9999999999999993, 0.5000000000000002]], [55, [-1.666666666666666, 0.3705904774487399]], [56, [-1.3333333333333328, 0.2500000000000002]], [57, [-0.9999999999999996, 0.14644660940672638]], [58, [-0.6666666666666663, 0.06698729810778076]], [59, [-0.333333333333333, 0.0170370868554659]]])
    end
  end

  # describe "create_new_frame" do
  #   it "creates a newly scaled, positioned, and cropped frame" do
  #     @test_object_001.create_new_frame("green", ".jpg", [2, -4], 9)
  #   end
  # end

  # describe "creates_frames_single" do
    # it "creates a series of newly scaled, positioned, and cropped frames" do
    #   keyframes_and_coordinates = [[0, [0, 0]], [9, [2, -4]], [15, [1, 1]], [20, [-2, 0]], [26, [3, 2]], [35, [3, 3]], [43, [1, 3]], [48, [-4, 1]], [60, [0, 0]]]
    #   all_frames_and_coordinates = @test_object_001.get_all_frames_and_coordinates(keyframes_and_coordinates)
    #   @test_object_001.creates_frames_from_single(all_frames_and_coordinates)
    # end
    # it "creates a series of newly scaled, positioned, and cropped frames" do
    #   @test_object_002.total_frames_of_clip = 300
    #   @test_object_002.set_number_of_keyframes(300)
    #   keyframes_and_coordinates = @test_object_002.combine_keyframes_with_their_coordinates(@test_object_002.get_circle_coordinates, @test_object_002.get_keyframes)
    #   all_frames_and_coordinates = @test_object_002.get_all_frames_and_coordinates(keyframes_and_coordinates)
    #   @test_object_002.creates_frames_from_single(all_frames_and_coordinates)
    # end
  # end

  # describe "creates_frames_sequence" do
  #   it "creates a series of newly scaled, positioned and cropped frames" do
  #     @test_object_003.total_frames_of_clip = 674
  #     @test_object_002.set_number_of_keyframes(674)
  #     keyframes_and_coordinates = @test_object_003.combine_keyframes_with_their_coordinates(@test_object_003.get_circle_coordinates, @test_object_003.get_keyframes)
  #     all_frames_and_coordinates = @test_object_003.get_all_frames_and_coordinates(keyframes_and_coordinates)
  #     @test_object_003.creates_frames_from_sequence(all_frames_and_coordinates)
  #   end
  # end

end
