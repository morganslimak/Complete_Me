class Node
  attr_accessor :children, :word, :partial

  def initialize(partial)
    @partial = partial
    @word = false
    @children = Hash.new
  end

end
