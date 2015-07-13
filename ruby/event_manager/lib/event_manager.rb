require 'csv'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,'0')[0..4]
end

puts "~~~Event Manager Initialized~~~\n\n"

contents = CSV.open "/home/aaron/the_odin_project/ruby/event_manager/event_attendees.csv", headers: true, header_converters: :symbol
contents.each do |row|
  name = row[:first_name]      # use symbols for header column titles by specifying header_converters
  zipcode = clean_zipcode(row[:zipcode])

  puts "#{name} #{zipcode}"
end

