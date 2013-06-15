class Bottle < ActiveRecord::Base
  belongs_to :owner, class_name: "User"

  validates :message, presence: true

  scope :delivered , -> { where('delivered_at IS NOT NULL') }
  scope :not_delivered_yet , -> { where('delivered_at IS NULL') }

  class << self
    def analize_words
      words = Hash.new(0)

      all.each do |bottle|
        tag = TAGGER.parse(bottle.message)

        tag.each do |node|
          feature = node.feature

          # XXX Bad code...
          if feature['名詞']
            words[node.surface] += 1
          end
        end
      end

      data = []
      words.each do |word, weight|
        data << {word: word, weight: weight}
      end
      data
    end

    def find_by_tag(tag)
      where(["message LIKE ?", "%#{tag}%"])
    end
  end

  def deliver!(date = DateTime.now)
    self.delivered_at = date
    save!
  end
end
