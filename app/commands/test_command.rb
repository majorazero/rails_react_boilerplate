# frozen_string_literal: true

module TestCommand
  extend self

  def execute
    test_stuff
  end

  private

  def test_stuff
    'I am working'
  end
end

