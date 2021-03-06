require 'byebug'

class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    each do |link|
      return link.val if link.key == key
    end
    nil
  end

  def include?(key)
    each do |link|
      return true if link.key == key
    end
    false
  end

  def insert(key, val)
    new_link = Link.new(key, val)
    if empty?
      @head.next = new_link
      @tail.prev = new_link
      new_link.prev = @head
      new_link.next = @tail
    else
      last.next = new_link
      new_link.prev = last
      @tail.prev = new_link
      new_link.next = @tail
    end
  end

  def remove(key)
    each do |link|
      # byebug
      if link.key == key
        next_link = link.next
        prev_link = link.prev
        prev_link.next = next_link
        next_link.prev = prev_link
      end
    end
  end

  def each(&prc)
    reference = @head
    while reference.next != @tail
      reference = reference.next
      prc.call(reference)
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
