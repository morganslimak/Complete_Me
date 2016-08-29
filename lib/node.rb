class Node
  attr_accessor :children, :word, :partial

  def initialize(partial=nil)
    @partial = partial
    @word = false
    @children = Hash.new
  end

end
