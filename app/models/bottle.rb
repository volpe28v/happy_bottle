class Bottle < ActiveRecord::Base
  belongs_to :owner, class_name: "User"

  class << self
    def analize_words
      words = Hash.new(0)

      model = MeCab::Model.new()
      tagger = model.createTagger
      all.each do |bottle|
        node = tagger.parseToNode(bottle.message)

        while node
          feature = node.feature

          # XXX Bad code...
          if feature['名詞']
            words[node.surface] += 1
          end

          node = node.next
        end
      end

      data = []
      words.each do |word, weight|
        data << {word: word, weight: weight}
      end
      data
    end
  end

  def deliver!(date = DateTime.now)
    self.delivered_at = date
    save!
  end
end
