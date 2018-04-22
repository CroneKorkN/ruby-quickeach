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
    "_original_each".to_sym,
    instance_method(:each)
  )

  def each &block
    unless block_given?
      return QuickEach.new self
    else
      _original_each &block 
    end
  end
end

class Hash
  # copy method
  define_method(
    "_original_each_key".to_sym,
    instance_method(:each_key)
  )
  def each_key &block
    unless block_given?
      return QuickEach.new self.keys
    else
      _original_each_key &block
    end
  end
  define_method(
    "_original_each_value".to_sym,
    instance_method(:each_value)
  )
  def each_value &block
    unless block_given?
      return QuickEach.new self.values
    else
      _original_each_value &block
    end
  end
end

# test
#a = ["alice", "bob", "jon doe"]
#p a.each.length 
#h = {alice: "wonderland", bob: "dylan", jon: "doe"}
#p h.each_key.length
#p h.each_value.length
