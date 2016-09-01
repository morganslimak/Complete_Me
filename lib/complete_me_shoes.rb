require_relative "complete_me"

trie = CompleteMe.new
dictionary = File.read("../usr/share/dict/words")
trie.populate(dictionary)


Shoes.app do

  background "#b3d9ff"
  border("#0059b3", strokewidth: 4)

  stack :height => "25%" do
    image "http://i.huffpost.com/gen/2424200/images/o-UNICORN-facebook.jpg", :width => 600, :height => 150
  end

  flow do

    stack margin: 10, :width => "50%" do
      @results = para
    end

    stack margin: 10, :width => "-50%" do
      para "Enter a partial word to complete:"

      flow do
        @autocomplete_line = edit_line
        @autcomplete_button = button "Search" do
          substring = @autocomplete_line.text
          suggestions = trie.suggest(substring)
          suggestions = suggestions.join(", ")
          @results.replace(suggestions)
        end
      end
      para ""
      para "Enter a word to delete:"

      flow do
        @delete_line = edit_line
        @delete_button = button "Delete" do
          word = @delete_line.text
          trie.delete(word)
          @results.replace("#{word.capitalize} has been deleted.")
        end
      end

      para ""
      para "Enter a substring and a
word separated by a space:"
      flow do
        @select_line = edit_line
        @select_button = button "Select" do
          words = @select_line.text.split
          trie.select(words.first, words.last)
          @results.replace("#{words.last.capitalize} will return as a priority when you enter #{words.first}!")
        end
      end

    end
  end
end
