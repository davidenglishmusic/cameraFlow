require_relative '../lib/cameraFlow'

describe CameraFlow do

  before :all do
    @test_object_001 = CameraFlow.new('c', 'field.mts')
    @test_object_002 = CameraFlow.new('b', 'field.mts')
    @test_object_003 = CameraFlow.new('h', 'field.mts')
    @test_object_004 = CameraFlow.new('h', 'field.vob')
  end

  describe 'help_information' do
    it 'returns the correct help information' do
      expect(@test_object_001.help_information).to eq('
      cameraFlow will accept the following file formats:
      Images:
      [".jpg", ".jpeg", ".gif", ".bmp", ".tif", ".png"]
      Videos:
      [".mov", ".mts", ".mp4", ".avi"]
      Here are two sample commands:
      ruby app.rb field.mov
      ruby app.rb ~/Desktop/forest.png 300
      *If entering an image as opposed to a video, be sure to add the length in frames')
    end
  end

  describe 'valid_command?' do
    it 'returns true if the command is valid' do
      expect(@test_object_001.valid_command?).to eq(true)
    end
    it 'returns false if the command is valid' do
      expect(@test_object_002.valid_command?).to eq(false)
    end
  end

  describe 'need_help?' do
    it 'returns true if the command is h' do
      expect(@test_object_003.need_help?).to eq(true)
    end
    it 'returns false if the command is not' do
      expect(@test_object_001.need_help?).to eq(false)
    end
  end

  describe 'need_help?' do
    it 'returns true if the command is h' do
      expect(@test_object_003.need_help?).to eq(true)
    end
    it 'returns false if the command is not' do
      expect(@test_object_001.need_help?).to eq(false)
    end
  end

  describe 'valid_extension?' do
    it 'returns true if the extension is valid' do
      @test_object_001.parse_filename_and_extension
      expect(@test_object_001.valid_extension?).to eq(true)
    end
    it 'returns false if the extension is not' do
      @test_object_004.parse_filename_and_extension
      expect(@test_object_004.valid_extension?).to eq(false)
    end
  end

end
