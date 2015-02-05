require 'fileutils'

NON_EMPTY_FOLDER_WARNING = 'The output folder is not empty.\n
  All files will be removed. Enter y to clear the directory or n to stop and exit:'

class StageCrew
  def prepare_bench
    tear_down_bench if File.directory? 'bench'
    FileUtils.mkdir 'bench'
  end

  def tear_down_bench
    FileUtils.rm_r Dir.glob('bench/*')
    FileUtils.rmdir 'bench'
  end

  def prepare_directory(directory_name)
    if File.directory? directory_name
      if Dir.entries(directory_name).size > 0 && can_clear_directory
        FileUtils.rm_r Dir.glob(directory_name)
        FileUtils.mkdir directory_name
      else
        puts 'Exiting'
        exit
      end
    else
      FileUtils.mkdir directory_name
    end
  end

  def can_clear_directory
    puts NON_EMPTY_FOLDER_WARNING
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
