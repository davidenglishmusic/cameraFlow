require 'fileutils'

class StageCrew
  def prepare_bench
    tear_down_bench if File.directory? 'bench'
    FileUtils.mkdir 'bench'
  end

  def tear_down_bench
    FileUtils.rm_r Dir.glob('bench/*')
    FileUtils.rmdir 'bench'
  end

  def prepare_output
    if File.directory? 'output'
      if Dir.entries('output').size > 0 && can_clear_directory
        FileUtils.rm_r Dir.glob('output')
        FileUtils.mkdir 'output'
      else
        puts 'Exiting'
        exit
      end
    else
      p "creating output dir"
      FileUtils.mkdir 'output'
    end
  end

  def can_clear_directory
    puts 'The output folder is not empty.'
    puts 'All files will be removed. Enter y to clear the directory or n to stop and exit:'
    answered_properly = false
    while answered_properly == false
      response = $stdin.gets.chomp!
      if response == 'y' || response == 'n'
        answered_properly = true
      else
        puts 'Please answer with y or n'
      end
    end
    if response == 'y'
      true
    else
      false
    end
  end
end
