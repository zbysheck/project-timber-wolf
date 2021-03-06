require 'squib'
require_relative 'helpers'
require 'pp'

data = Squib.xlsx(file: 'data/data.xlsx', sheet: 1) do |col, item|
  newlineate(col, item)
end
total = data['Name'].size
# File.open('data/skills.txt', 'w+') { |f| f.write data.to_pretty_text }

Squib::Deck.new(cards: total, width: 1125, height: 825) do
  use_layout file: 'layouts/skills.yml'
  background color: :white
  rect layout: :cut

  svg file: 'skill.svg' # black-and-white
  build :color do
    grits = data['Level'].map do |level|
      level == '1' ? "gritty amateur.png" : "gritty pro.png"
    end
    png file: grits, angle: Math::PI/2, x: 1125, y: 0
    svg file: 'skill-color.svg' #, range: 0
  end

  text str: data['Level'].map { |l| l == '1' ? "Amateur Skill" : "Pro Skill" },
       layout: :level

  text str: data['Rolls'].map { |s| skill_lacks(s) }, layout: :lacks
  text str: data['Name'], layout: :name
  (1..6).each do |i|
    text str: data[i.to_s], layout: "die_roll_#{i}"
  end

  save_png prefix: 'skill_', rotate: true
  save_pdf file: 'skills.pdf', trim: '0.125in'
  build :color do
    showcase file: 'skill_showcase.png', range: [0,2,4], fill_color: :black
    showcase file: 'skill_showcase2.png', range: [6,8,10], fill_color: :black
    showcase file: 'skill_showcase_levelup.png', range: [4,21,22],
            fill_color: :black
  end


  build :rulebook_figures do
    rect layout: :border
    %i(Action DieRoll).each do |fig|
      text layout: "Figure#{fig}"
    end

    showcase range: 0,
             dir: 'rules', file: 'skill_example.png',
             trim: 37.5, fill_color: '#0000', scale: 0.9
  end
end
