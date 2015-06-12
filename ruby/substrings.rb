dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

def substrings(query, dictionary)
    query.downcase!
    substrings = {}

    dictionary.each do |term|
        matches = query.scan(term).count
        substrings[term] = matches if matches > 0
    end

    substrings
end

p substrings("below", dictionary)
p substrings("Howdy partner, sit down! How's it going?", dictionary)
