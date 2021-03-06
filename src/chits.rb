require 'squib'
require_relative 'save_custom_sheet'

#################################
## Based on TGC's Medium Chits ##
#################################
puts "Building medium chits..."
data = Squib.xlsx file: 'data/security_tokens.xlsx', explode: ''
Squib::Deck.new(width: 300, height: 300, cards: data['Name'].size) do
  use_layout file: 'layouts/tgc_medium_circle_chit.yml'
  background color: :white

  build :color do
    background color: '#42290d' # dark brown
    svgdata = data['Image'].map do |svg|
      File.read("img/#{svg}").gsub('fill:#000000', 'fill:#d8c586')  # tan color
    end
    svg data: svgdata, width: 225, height: 225, x: 37.5, y: 37.5
  end

  build :proof do
    circle layout: :cut
    circle layout: :safe
  end

  save_avery_5408

  save_png prefix: 'security_token_', count_format: data['File']
end

###################################
## Based on TGC's Bullseye Chits ##
###################################
puts "Building bullseye chits..."
Squib::Deck.new(width: 375, height: 900, cards: 4) do
  cyan = '#40bfbd'; purple = '#bf40ba'; yellow = '#c8cc31'
  background color: [cyan, purple, yellow, yellow]
  rect fill_color: '#42290d', width: width, height: 200
  svg file: 'jewel-chit.svg'
  save_png prefix: 'pressure_token_', count_format: '%02d_[all]'
end

################################################
## Based on TGC's Large Circle & Square Chits ##
################################################
puts 'Building large chits...'
data = Squib.xlsx file: 'data/security_tokens.xlsx', explode: '', sheet: 1
Squib::Deck.new(width: 375, height: 375, cards: data['Name'].size) do
  background color: data['BGColor']

  svgdata = data['Img'].map.with_index do |svg, i|
    File.read("img/#{svg}").gsub('fill:#000000', "fill:#{data['FGColor'][i]}")
  end
  svg data: svgdata
  # png file: 'large-circle-chit.png', alpha: 0.5
  #png file: 'large-square-chit.png', alpha: 0.5
  save_png prefix: 'lg', count_format: data['File']
end

#######################################
## Based on TGC's Small Circle Chits ##
#######################################
puts 'Building small chits...'
data = Squib.xlsx file: 'data/security_tokens.xlsx', explode: '', sheet: 2
Squib::Deck.new(width: 225, height: 225, cards: data['Name'].size) do
  background color: data['BGColor']

  svgdata = data['Img'].map.with_index do |svg, i|
    File.read("img/#{svg}").gsub('fill:#000000', "fill:#{data['FGColor'][i]}")
  end
  svg data: svgdata
  # png file: 'small-circle-chit.png', alpha: 0.5
  save_png prefix: 'sm', count_format: data['File']
end
