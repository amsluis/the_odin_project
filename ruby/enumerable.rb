#! /usr/bin/env ruby

module Enumerable
  def my_each
    return self unless block_given?
    for i in self
      yield(i)
    end
  end

  def my_each_with_index
    return self unless block_given?
    count = 0
    for i in self
      yield(i, count)
      count += 1
    end
  end

  def my_select
    return self unless block_given?   #should actually return enumerable object
    answer = []
    self.my_each do |item|
      if yield(item)
        answer.push(item)
      end
    end
    return answer
  end

  def my_all?
    self.my_each do |item|
      unless yield(item)
        return false
      end
    end
    return true
  end

  def my_none?
    self.my_each do |item|
      if yield(item)
        return false
      end
    end
    return true
  end

  def my_count
    count = 0
    self.each {count += 1}
    count
  end

  def my_map
    return self unless block_given?
    answer = []
    self.my_each {|i| answer.push(yield(i))}
    return answer
  end

  def my_inject(initial=nil)
    total = initial.nil? ? self[0] : initial 
    self[1..self.length].my_each do |item|
      total = yield(total, item)
    end
    total
  end
end

def multiply_els(array)
  array.my_inject {|total,item| total*item}
end
