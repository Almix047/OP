# frozen_string_literal: true

require_relative 'record_to_file.rb'

# URL = 'https://catalog.onliner.by/notebook?price%5Bto%5D=1500.00&diagonalnb%5Bto%5D=156&display_resnb%5Bfrom%5D=1920x1080&ram_sizenb%5Bfrom%5D=6gb&ram_typenb%5B0%5D=ddr4&ram_typenb%5B1%5D=lpddr4&ram_typenb%5B2%5D=lpddr4x&ram_typenb%5Boperation%5D=union&max_ram_sizenb%5B0%5D=10gb&max_ram_sizenb%5B1%5D=16gb&max_ram_sizenb%5B2%5D=12_gb&max_ram_sizenb%5B3%5D=20gb&max_ram_sizenb%5B4%5D=24gb&max_ram_sizenb%5B5%5D=32gb&max_ram_sizenb%5B6%5D=48&max_ram_sizenb%5B7%5D=40&max_ram_sizenb%5B8%5D=64&max_ram_sizenb%5B9%5D=128gb&max_ram_sizenb%5Boperation%5D=union&ram_slotsnb%5B0%5D=1s&ram_slotsnb%5B1%5D=2s&ram_slotsnb%5B2%5D=4s&ram_slotsnb%5Boperation%5D=union&cover_typenb%5B0%5D=matt&cover_typenb%5Boperation%5D=union'
URL =  Dir['../cache/*.html'][0]

RecordToFile.save_as_csv_file
