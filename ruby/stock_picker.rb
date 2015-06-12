def stock_picker(prices)
    minimum_day = 0
    maximum_day = 0
    profit_day = 0
    profit = 0
    
    prices.each_with_index do |price, i|
        if price < prices[minimum_day]
            minimum_day = i
        end
        if price > prices[maximum_day]
            maximum_day = i
        end
        if price - prices[minimum_day] > profit
            profit = price - prices[minimum_day]
            profit_day = [minimum_day, i]
        end
    end
    return profit_day
end

p stock_picker([17,3,6,9,15,8,6,1,10])
