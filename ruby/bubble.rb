#!/usr/bin/env ruby

# A bubble sorting algorithm
# Accept an array and return a sorted array
# Extend Array class to call from array object

class Array
  def bubble_sort
    i = self.length - 1
    while i > 0
      (0..(i-1)).each do |j|
        if self[j + 1] < self[j]
          self[j],self[j+1] = self[j+1],self[j]
        end
      end
      i -= 1
    end
    return self
  end

  def bubble_sort_by 
    i = self.length - 1
    while i > 0
      (0..(i-1)).each do |j|
        a = self[j]
        b = self[j + 1]
        if yield(a,b) > 0
          self[j],self[j+1] = self[j+1],self[j]
        end
      end
      i -= 1
    end
    return self
  end
end


test = [4,23,7,5,2,1]

puts test.bubble_sort

words = ['one', 'bigger', 'is']

puts words.bubble_sort_by {|a,b| a.length - b.length}
