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
        return self unless block_given?
        answer = []
        self.my_each do |item|
            if yield(item)
                answer.push(item)
            end
        end
        return answer
    end
end

