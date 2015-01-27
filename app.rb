require_relative 'lib/cameraFlow'
require_relative 'lib/stageCrew'

# Command Sequence

camera_flow = CameraFlow.new(ARGV[0], ARGV[1])
stage_crew = StageCrew.new

camera_flow.run_validations

stage_crew.prepare_bench

stage_crew.prepare_output

camera_flow.add_source_to_bench

camera_flow.set_resolution

camera_flow.set_frame_total

camera_flow.start_flow

stage_crew.tear_down_bench

puts 'Please check the output folder'
