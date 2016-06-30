require 'squib'
require 'launchy'

task default: [
  :full,
  :rulebook_figures,
  :security,
  :characters,
  :character_backs,
  :skills,
  :skill_backs,
  :helps
]

task :full do
  ENV['SQUIB_BUILD'] ||= ''
  ENV['SQUIB_BUILD'] += ',full'
end

task color: [:with_color, :default]

task :lvl1 do
  ENV['SQUIB_BUILD'] ||= ''
  ENV['SQUIB_BUILD'] += ',lvl1'
end

task :rulebook_figures do
  ENV['SQUIB_BUILD'] ||= ''
  ENV['SQUIB_BUILD'] += ',rulebook_figures'
end

task :security do
  load 'src/security.rb'
end

task :characters do
  load 'src/characters.rb'
  @launch ||= []
  @launch << "file:///#{Dir.pwd}/_output/characters.pdf"
end

task :character_backs do
  load 'src/character_backs.rb'
  @launch ||= []
  @launch << "file:///#{Dir.pwd}/_output/character_backs.pdf"
end

task :skills do
  load 'src/skills.rb'
  @launch ||= []
  @launch << "file:///#{Dir.pwd}/_output/skills.pdf"
end

task :skill_backs do
  load 'src/skill_backs.rb'
  @launch ||= []
  @launch << "file:///#{Dir.pwd}/_output/skill_backs.pdf"
end

task :helps do
  load 'src/helps.rb'
end

task :launch do
  return unless @launch.respond_to? :each
  @launch.each do |url|
    puts "Launching #{url}"
    Launchy.open url
  end
end

task :data do
  url = "file:///#{Dir.pwd}/data/data.xlsx"
  puts "Launching #{url}"
  Launchy.open url
end
