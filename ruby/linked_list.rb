class LinkedList
  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def append(value)
    node = Node.new(value)
    if @tail
      @tail.next_node = node
    end
    if @head.nil?
      @head = node
    end
    @tail = node
    @size += 1
  end

  def prepend(value)
    node = Node.new(value, @head)
    @head = node
    if @tail.nil?
      @tail = node
    end
    @size += 1
  end

  def head
    @head.value
  end

  def tail
    @head.value
  end

  def at(index)
    count = index
    node = @head
    while count > 0
      node = node.next_node
      count -= 1
    end
    return "The value at index #{index} is: #{node.value}"
  end

  def pop
    node = @head
    while node.next_node
      penultimate = node
      node = node.next_node
    end
    penultimate.next_node = nil
    pop = @tail
    @tail = penultimate
    return pop
  end

  def contains?(value)
    node = @head
    while true
      if node.value == value
        return true
      end
      break unless node.next_node
      node = node.next_node
    end
    return false
  end

  def find(value)
    node = @head
    index = 0
    while true
      if node.value == value
        return "\'#{value}\' found at #{index}"
      end
      break unless node.next_node
      node = node.next_node
      index += 1
    end
    return "Value not found"
  end

  def to_s
    node = @head
    while true
      unless node.value.nil?
        puts node.value + " --> "
      end
      node = node.next_node
      break if node.nil?
    end
  end

end


class Node
  attr_reader :value
  attr_accessor :next_node

  def initialize(value, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

