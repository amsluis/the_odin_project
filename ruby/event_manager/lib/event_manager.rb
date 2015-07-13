require 'csv'
require 'sunlight/congress'
require 'erb'

Sunlight::Congress.api_key = "cb32ca6fb627490582211aa31c2227dc"
data_file = "/home/aaron/the_odin_project/ruby/event_manager/event_attendees.csv"
template_file = "/home/aaron/the_odin_project/ruby/event_manager/form_letter.erb"

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,'0')[0..4]
end

def legislators_by_zipcode(zipcode)
  legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def save_thank_you_letters(id,form_letter)
  Dir.mkdir('output') unless Dir.exists? 'output'
  filename = "output/thanks_#{id}.html"
  File.open(filename,'w') do |file|
    file.puts form_letter
  end
end

puts "~~~Event Manager Initialized~~~\n\n"

contents = CSV.open data_file, headers: true, header_converters: :symbol
template_letter = File.read template_file
erb_template = ERB.new template_letter

contents.each do |row|
  id = row[0]
  name = row[:first_name]      # use symbols for header column titles by specifying header_converters
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)
  save_thank_you_letters(id,form_letter)
end

