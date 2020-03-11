# frozen_string_literal: true

require 'pry'
# Configuration of the output view
class OutputList
  HEADER = %w[Name Price Image].freeze

  attr_reader :list_data, :pages

  def initialize(pages)
    @pages = pages
    @rows = []
  end

  def call
    prepare_list_data
  end

  private

  def prepare_list_data
    binding.pry
  end
end
