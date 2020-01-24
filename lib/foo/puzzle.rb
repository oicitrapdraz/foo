# frozen_string_literal: true

require 'matrix'

module Foo
  class Puzzle
    attr_reader :valid, :submatrixes

    SUBMATRIXES_INDIXES = [0, 3, 6].freeze
    ROW_INDIXES = (0..8).to_a
    COLUMN_INDIXES = (0..8).to_a

    def initialize(file_path)
      lines = FileParser.new(file_path).parse

      matrix = Matrix[*lines]

      @submatrixes =
        SUBMATRIXES_INDIXES.each_with_object([]) do |i, array|
          SUBMATRIXES_INDIXES.each do |j|
            array << matrix.minor(i..i + 2, j..j + 2)
          end
        end
    end

    def valid?
      no_subgroup_duplicates && no_row_duplicates && no_column_duplicates
    end

    private

    def no_subgroup_duplicates
      submatrixes.all? do |matrix|
        matrix_values = matrix.each(:all).to_a
        repeated_non_zero_element?(matrix_values)
      end
    end

    def no_row_duplicates
      ROW_INDIXES.all? do |i|
        repeated_non_zero_element? row(i)
      end
    end

    def no_column_duplicates
      COLUMN_INDIXES.all? do |j|
        repeated_non_zero_element? column(j)
      end
    end

    def repeated_non_zero_element?(array)
      non_zero_elements = array.reject(&:zero?)

      non_zero_elements.uniq.length == non_zero_elements.length
    end

    def row(index)
      submatrixes[(index / 3) * 3].row(index % 3).to_a +
        submatrixes[(index / 3) * 3 + 1].row(index % 3).to_a +
        submatrixes[(index / 3) * 3 + 2].row(index % 3).to_a
    end

    def column(index)
      submatrixes[(index / 3)].column(index % 3).to_a +
        submatrixes[(index / 3) + 3].column(index % 3).to_a +
        submatrixes[(index / 3) + 6].column(index % 3).to_a
    end
  end
end
