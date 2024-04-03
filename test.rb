# puts Dir.pwd()

# directory=Dir.pwd()
# puts Dir.glob(File.join(Dir.pwd(), "**/*.pdf"))
require 'rmagick'

# pathes = Dir.glob(File.join(Dir.pwd(), "**/*.pdf"))
# puts pathes
# for path in pathes do
#     list=Magick::ImageList.new(path)
#     list.each_with_index do |page, index|
#         puts page
#         puts index
#         `mkdir tmp && mkdir tmp/images`
#         image_path="#{Dir.pwd()}/tmp/images/#{index}.jpg"
#         puts image_path
#         # `touch #{image_path}`
#         page.write(image_path)
#     end
#     puts list
# end

# count=0
# puts count+=1
# puts Dir.glob(File.join(Dir.pwd(), "**/*.pdf")).length
# File.open('table.sql', 'r') do |f|
#     f.readlines.each do |line|
#         puts line
#         line.strip.downcase
#         if line.strip.downcase.index('create table')
#             puts line
#         else
#             # puts 'not table'
#         end
#     end
# end

module Test
    class TestClass
        MAX_ATTEMP_VALUES = 3
        def test
            puts MAX_ATTEMP_VALUES
        end
    end
end

Test::TestClass.new.test