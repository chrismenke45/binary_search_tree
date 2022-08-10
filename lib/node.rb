class Node
  attr_reader :data
  attr_accessor :left, :right

  def initialize(data = nil, right = nil, left = nil)
    @data = data
    @right = right
    @left = left
  end
end
