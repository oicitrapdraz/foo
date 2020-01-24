# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Foo::Puzzle do
  context 'when file exists with correct syntax' do
    before :all do
      open('valid_complete.sudoku', 'w') do |f|
        f.puts '8 5 0 |0 0 2 |4 0 0'
        f.puts '7 2 0 |0 0 0 |0 0 9'
        f.puts '0 0 4 |0 0 0 |0 0 0'
        f.puts '------+------+------'
        f.puts '0 0 0 |1 0 7 |0 0 2'
        f.puts '3 0 5 |0 0 0 |9 0 0'
        f.puts '0 4 0 |0 0 0 |0 0 0'
        f.puts '------+------+------'
        f.puts '0 0 0 |0 8 0 |0 7 0'
        f.puts '0 1 7 |0 0 0 |0 0 0'
        f.puts '0 0 0 |0 3 6 |0 4 0'
      end
    end

    it 'should correctly validate' do
      expect(Foo::Puzzle.new('valid_complete.sudoku').valid?).to be true
    end

    after :all do
      if File.exist?('valid_complete.sudoku')
        File.delete('valid_complete.sudoku')
      end
    end
  end

  context "when file doesn't exists" do
    it 'should raise an exception' do
      expect { Foo::Puzzle.new('non_existing_file.sudoku').parse }.to raise_error(Errno::ENOENT)
    end
  end
end