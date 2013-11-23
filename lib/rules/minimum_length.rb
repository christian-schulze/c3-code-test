
module Rules
  class MinimumLength

    def initialize(column_name, options = {})
      @column_name = column_name
      @minimum_length = options[:minimum_length]
    end

    def valid?(row)
      return false unless row.has_key?(@column_name)

      row[@column_name].length >= @minimum_length
    end

  end
end
