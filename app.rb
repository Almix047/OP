# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'csv'
require 'pry'

# URL = 'https://catalog.onliner.by/notebook?price%5Bto%5D=1500.00&diagonalnb%5Bto%5D=156&display_resnb%5Bfrom%5D=1920x1080&ram_sizenb%5Bfrom%5D=6gb&ram_typenb%5B0%5D=ddr4&ram_typenb%5B1%5D=lpddr4&ram_typenb%5B2%5D=lpddr4x&ram_typenb%5Boperation%5D=union&max_ram_sizenb%5B0%5D=10gb&max_ram_sizenb%5B1%5D=16gb&max_ram_sizenb%5B2%5D=12_gb&max_ram_sizenb%5B3%5D=20gb&max_ram_sizenb%5B4%5D=24gb&max_ram_sizenb%5B5%5D=32gb&max_ram_sizenb%5B6%5D=48&max_ram_sizenb%5B7%5D=40&max_ram_sizenb%5B8%5D=64&max_ram_sizenb%5B9%5D=128gb&max_ram_sizenb%5Boperation%5D=union&ram_slotsnb%5B0%5D=1s&ram_slotsnb%5B1%5D=2s&ram_slotsnb%5B2%5D=4s&ram_slotsnb%5Boperation%5D=union&cover_typenb%5B0%5D=matt&cover_typenb%5Boperation%5D=union'
URL =  Dir['../cache/*.html'][0]

page = Nokogiri::HTML(open(URL))

products = []
detail = {}

products_on_page1 = page.xpath("//div[contains(@class, 'schema-product__part schema-product__part_2')]")

products_on_page1.each_with_index do |product, index|
  puts "#{index + 1}: ---- "
  puts " TITLE: #{detail['Title'] = product.children[3].children[1].children[1].children[1].text}"
  puts " DESCRIPTION: #{detail['Description'] = product.children[3].children[5].children[1].text.gsub(/[\n]/, '').gsub(/[\"]/, ',')}"
  puts " PRODUCT_LINK: #{detail['Product_link'] = product.children[3].children[1].children[1].attributes['href'].text}"

  puts " PRICE: #{detail['Price'] = if product.children[1].children[1].children[13].children[3].children[1].nil?
      puts "!!!HOT: -#{detail['Discont'] = product.children[1].children[1].children[13].children[6].children[1].children[1].children[1].text.to_i}%"
      product.children[1].children[1].children[13].children[6].children[1].children[3].children[1].text.gsub(',', '.').to_f
    else
      detail['Discont'] = 0
      product.children[1].children[1].children[13].children[3].children[1].children[1].text.gsub(',', '.').to_f
    end}"

  detail['Second-hand_price'] = if product.children[1].children[1].children[19].children[1].nil?
      detail['Second-hand_link'] = 'no item'
      'no item'
    else
      puts "!!!USED: #{product.children[1].children[1].children[19].children[1].children[1].children[1].text}"
      puts "#{detail['Second-hand_link'] = product.children[1].children[1].children[19].children[1].children[1].attributes['href'].value}"
      product.children[1].children[1].children[19].children[1].children[1].children[1].text
    end

  puts " OFFER: #{detail['Trading_offers'] = product.children[1].children[1].children[13].children[10].children[1].children.text.to_i}"
  puts " OFFER_LINK: #{detail['Trading_offers_link'] = product.children[1].children[1].children[13].children[10].children[1].values[3]}"

  puts " REVIEWS: #{detail['Reviews'] = if product.children[3].children[7].children[1].children[3].children[3].nil?
      0
    else
      product.children[3].children[7].children[1].children[3].children[3].children[1].text.to_i
    end}"
  puts " REVIEWS/RATED_LINK: #{detail['Reviews_link'] = product.children[3].children[7].children[1].children[3].values.last}"

  puts " DISCUSSION: #{detail['Discussion'] = product.children[3].children[7].children[3].children[12].text.to_i}"
  puts " DISCUSSION_LINK: #{detail['Discussion_link'] =  if product.children[3].children[7].children[3].children[3].attributes['href'].nil?
      "discussion didn't start"
    else
      product.children[3].children[7].children[3].children[3].attributes['href'].value
    end}"

  puts " RATED: #{detail['Rated'] = if product.children[3].children[7].children[1].children[3].children[1].nil?
    'not rated yet'
  else
    product.children[3].children[7].children[1].children[3].children[1].attributes['class'].value.gsub(/['rating rating_']/, '').to_f/10
  end}"
  # binding.pry
  products.push(detail)
end

CSV.open('result.csv', 'wb') do |csv|
  products.map(&:values).each { |row| csv << row }
end
