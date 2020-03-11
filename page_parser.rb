# frozen_string_literal: true

# require 'selenium-webdriver'
require 'open-uri'
require 'nokogiri'

# Scraping information from site
class PageParser
  attr_reader :link

  def initialize(link)
    @link = link
  end

  def fetch_page
    @fetch_page ||= parse_page(link)
  end

  private

  def parse_page(link)
    Nokogiri::HTML(open(link))
  end
end
