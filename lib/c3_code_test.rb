require 'csv'

DATA_PATH = File.expand_path(File.join(File.dirname(__FILE__), '../data'))

class C3CodeTest

  def process_file(file_path)
    CSV.foreach(file_path, headers: true) do |row|
      process_row(row)
    end
  end

  def process_row(row)

  end

end
