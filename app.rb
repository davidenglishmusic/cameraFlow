require_relative 'lib/cameraFlow'
require_relative 'lib/stageCrew'

OUTPUT_DIRECTORY = 'output'
LOGS_DIRECTORY = 'logs'

# Command Sequence

camera_flow = CameraFlow.new(ARGV[0], ARGV[1])
stage_crew = StageCrew.new

camera_flow.run_validations

stage_crew.prepare_bench

stage_crew.prepare_directory(OUTPUT_DIRECTORY)

stage_crew.prepare_directory(LOGS_DIRECTORY)

camera_flow.add_source_to_bench

camera_flow.set_resolution

camera_flow.set_frame_total

camera_flow.start_flow

stage_crew.tear_down_bench

puts "Please check the #{OUTPUT_DIRECTORY} folder"
