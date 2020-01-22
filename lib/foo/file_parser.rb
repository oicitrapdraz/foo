# frozen_string_literal: true

module Foo
  class FileParser
    attr_reader :file_path, :lines

    def initialize(file_path)
      @file_path = file_path
      @lines = []
    end

    def parse
      @lines = File.foreach(file_path).map do |line|
        next if line.include? '-'

        line.gsub('|', '').split.map(&:to_i)
      end.compact
    end
  end
end
