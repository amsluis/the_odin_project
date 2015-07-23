require 'jumpstart_auth'

class MicroBlogger
  attr_reader :client

  def initialize
    puts "Initializing MicroBlogger"
    @client = JumpstartAuth.twitter
  end

  def run
    puts "Welcome to the JSL Twitter Client"
    command = ""
    while command != "q"
      printf "enter command: "
      input = gets.chomp
      parts = input.split(' ')
      command = parts[0]
      case command
        when 'q' then puts "Goodbye!"
        when 't' then tweet(parts[1..-1].join(' '))
        when 'dm' then dm(parts[1], parts[2..-1].join(' '))
        when 'spam' then spam_followers(parts[1..-1].join(' '))
        else
          puts "Sorry, I don't know how to #{command}"
        end
    end
  end

  def tweet(message)
    if message.length <= 140
      @client.update(message)
    else
      puts "Message too long!"
    end
  end

  def followers_list
    screen_names << @client.user(follower).screen_name
    screen_names
  end

  def dm(target, message)
    screen_names = followers_list
    if screen_names.include? target
      puts "Sending #{target} your message:\n #{message}"
      message = "d @#{target} #{message}"
      tweet(message)
    else
      puts "Sorry, #{target} does not follow you."
    end
  end

  def spam_followers(message)
    followers_list.each { |follower| dm(follower, message) }
  end

  def everyones_last_tweet
    followers = @client.user(follower)
    followers.each do |follower|
      name = follower.screen_name
      status = follower.status
      puts "#{name} said... #{status}"
    end
  end
end

blogger = MicroBlogger.new
blogger.run
