class Node
  attr_accessor :children, :word, :partial, :selects

  def initialize(partial=nil)
    @partial = partial
    @word = false
    @children = Hash.new
    @selects = 0
  end

end
