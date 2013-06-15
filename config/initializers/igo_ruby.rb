dic = Rails.root.join('vendor/ipadic').to_s
TAGGER = Igo::Tagger.new(dic)
