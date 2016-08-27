class Node
  attr_accessor :children, :word

  def initialize
    @word = false
    @children = Hash.new
  end

end
