require_relative 'lib/cameraFlow'

# Command Sequence

camera_flow = CameraFlow.new(ARGV[0], ARGV[1])

camera_flow.run_validations

camera_flow.prepare_bench

camera_flow.set_resolution

camera_flow.set_frame_total

camera_flow.start_flow

puts 'Flow complete'
puts 'Tearing down the bench'
camera_flow.tear_down_bench

puts 'Please check the output folder'
