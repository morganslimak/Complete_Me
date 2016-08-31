require_relative "complete_me"
# require_relative "../usr/share/dict/words"

trie = CompleteMe.new
dictionary = File.read("../usr/share/dict/words")
trie.populate(dictionary)


Shoes.app do
  background "#b3d9ff"
  border("#0059b3", strokewidth: 4)

  stack(margin: 8) do
    para "Enter a partial word to autocomplete:"
    flow do
      @edit_line = edit_line
      @button = button "Search" do
        substring = @edit_line.text
        suggestions = trie.suggest(substring)
        suggestions = suggestions.join(", ")
        @results.remove if @results
        @results = para suggestions
      end
    end
  end
end
