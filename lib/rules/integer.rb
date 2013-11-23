
module Rules
  class Integer

    def initialize(column_name, options = {})
      @column_name = column_name
    end

    def valid?(row)
      return false unless row.has_key?(@column_name)

      integer?(row[@column_name])
    end

    def failure_message(row)
      "#{@column_name}: #{row[@column_name]} is not an integer."
    end

    private

    def integer?(value)
      /^[-+]?\d+$/ === value
    end

  end
end
