#!/usr/bin/env ruby

class QuickEach
  def initialize enumerable
    @enumerable = enumerable
  end

  def method_missing method, *args, &block
    @enumerable.collect do |element|
      element.send method, *args, &block
    end
  end
end

class Array
  # copy method
  define_method(
    "__each".to_sym,
    [].method(:each)
  )

  def each &block
    return QuickEach.new self unless block_given?
    __each &block 
  end
end

# array = ["alice", "bob", "jon doe"]
# array.each.length 
# => [5, 3, 6]
