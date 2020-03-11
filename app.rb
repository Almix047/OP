# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'pry'

# URL = 'https://catalog.onliner.by/notebook?price%5Bto%5D=1500.00&diagonalnb%5Bto%5D=156&display_resnb%5Bfrom%5D=1920x1080&ram_sizenb%5Bfrom%5D=6gb&ram_typenb%5B0%5D=ddr4&ram_typenb%5B1%5D=lpddr4&ram_typenb%5B2%5D=lpddr4x&ram_typenb%5Boperation%5D=union&max_ram_sizenb%5B0%5D=10gb&max_ram_sizenb%5B1%5D=16gb&max_ram_sizenb%5B2%5D=12_gb&max_ram_sizenb%5B3%5D=20gb&max_ram_sizenb%5B4%5D=24gb&max_ram_sizenb%5B5%5D=32gb&max_ram_sizenb%5B6%5D=48&max_ram_sizenb%5B7%5D=40&max_ram_sizenb%5B8%5D=64&max_ram_sizenb%5B9%5D=128gb&max_ram_sizenb%5Boperation%5D=union&ram_slotsnb%5B0%5D=1s&ram_slotsnb%5B1%5D=2s&ram_slotsnb%5B2%5D=4s&ram_slotsnb%5Boperation%5D=union&cover_typenb%5B0%5D=matt&cover_typenb%5Boperation%5D=union'
URL =  Dir['../cache/*.html'][1]

page = Nokogiri::HTML(open(URL))

products_arr = []
product_arr = []
detail = {}

products_on_page1 = page.xpath("//div[contains(@class, 'schema-product__part schema-product__part_2')]")

products_on_page1.each_with_index do |product, index|
  # binding.pry if index == 18
  # binding.pry if product.children[3].children[1].children[1].children[1].text == 'Ноутбук ASUS X509FL-BQ321'
  puts detail['Title'] = product.children[3].children[1].children[1].children[1].text
  puts detail['Description'] = product.children[3].children[5].children[1].text.gsub(/[\n]/, '').gsub(/[\"]/, ',')
  puts detail['Product_link'] = product.children[3].children[1].children[1].attributes['href'].text

  puts detail['Price'] = if product.children[1].children[1].children[13].children[3].children[1].nil?
      puts "!!!HOT: -#{product.children[1].children[1].children[13].children[6].children[1].children[1].children[1].text}%"
      product.children[1].children[1].children[13].children[6].children[1].children[3].children[1].text.gsub(',', '.').to_f
    else
      product.children[1].children[1].children[13].children[3].children[1].children[1].text.gsub(',', '.').to_f
    end
  unless product.children[1].children[1].children[19].children[1].nil?
    puts "!!!USED: #{product.children[1].children[1].children[19].children[1].children[1].children[1].text}"
    puts product.children[1].children[1].children[19].children[1].children[1].attributes['href'].value
  end

  puts detail['Trading_offers'] = product.children[1].children[1].children[13].children[10].children[1].children.text
    # binding.pry
  # puts detail['Trading_offers_link'] = products_on_page1.first.children[1].children[1].children[13].children[10].children[1].values[3] #wrong aways
  puts "#{index + 1}: ---- "

  # detail['Reviews'] = product
  # detail['Reviews_link'] = product

  # detail['Discussion'] = product
  # detail['Discussion_link'] = product

  # detail['Rated'] = product[5].children[3].children[7].children[1].children[3].children[1].attributes['class'].value.reverse.to_i.to_s.reverse.to_f/10

  # product_arr.push(detail)
end

# # Отзывы (Reviews/Rated) link

# products_on_page1.first.children[3].children[7].children[1].children[3].values.last

# # Отзывы ( reviews) if have

# products_on_page1.first.children[3].children[7].children[1].children[3].children[3].children[1].text

# # If haven’t
# products_on_page1[6].children[3].children[7].children[1].children[6].text

# # If have discuss
# products_on_page1[5].children[3].children[7].children[3].children[12].text

# # if haven’t discuss
# products_on_page1[0].children[3].children[7].children[3].children[6].text

# XPath links

# https://www.guru99.com/using-contains-sbiling-ancestor-to-find-element-in-selenium.html
