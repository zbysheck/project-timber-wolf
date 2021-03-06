require 'squib'
require_relative 'helpers'
require 'pp'

data = Squib.xlsx(file: 'data/data.xlsx') do |col, item|
  newlineate(col, item)
end
total = data['Name'].size

Squib::Deck.new(cards: total) do
  use_layout file: 'layouts/character_backs.yml'
  background color: :white
  rect layout: :cut

  svg file: 'character_back.svg'

  build :color do
    grits = data['Level'].map do |level|
      level == '1' ? "gritty amateur.png" : "gritty pro.png"
    end
    png file: grits
    svg file: 'character-back-color.svg'#, range: 0
    svg file: data['Name'].map { |n| "shadows/#{n.downcase}.svg" },
        x: 330, y: 170, width: 450, height: :scale
  end

  text str: data['Name'], layout: :name
  text str: data['LevelUp1'], layout: :upgrade1
  text str: data['LevelUp1Desc'], layout: :upgrade1desc
  text str: data['LevelUp2'], layout: :upgrade2
  text str: data['LevelUp2Desc'], layout: :upgrade2desc


  save_png prefix: 'character_back_'
  only_lvl1_2 = data['Level'].map.with_index do |x,i|
    [1].include?(x.to_i) ? i : nil
  end.compact
  save_pdf file: 'character_backs.pdf', trim: '0.125in', range: only_lvl1_2
end
