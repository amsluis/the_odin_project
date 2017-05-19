require 'sinatra'
require 'sinatra/reloader'

configure do
  enable :sessions
end

get '/' do
  @message = params["message"]
  @offset = params["offset"]
  puts @message, @offset

  unless @offset == ''
    session["offset"] = @offset
    puts "setting session offset to #{@offset}"
  end

  if @message == '' and session["offset"] == ''
    response = "Please enter a message to encrypt, and an encryption offset."
  elsif @message == ''
    response = "Please enter a message to encrypt."
  elsif @offset == ''
    @offset = session["offset"]
    puts "using session offset"
    response = encrypt(@message, @offset)
  else
    response = encrypt(@message, @offset)
  end

  erb :index, :locals => {:response => response, :offset => @offset}
end

def encrypt(message, offset)
  message = message.chomp.to_s
  offset = offset.to_i

  answer = []
  message.split.each do |word|
    output = []
    word.split('').each do |letter|
      if 65 <= letter.ord and letter.ord <= 90
        output << (((letter.ord + offset - 65) % 25) + 65).chr
      elsif 97 <= letter.ord and letter.ord <= 122
        output << (((letter.ord + offset - 97) % 25) + 97).chr
      end
    end
    answer << output.join('')
  end
  answer.join(' ')
end
