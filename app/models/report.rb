class Report < ApplicationRecord
  before_save :extract_keywords
  
  validates :content, presence: true

  def extract_keywords
    self.keywords = content.downcase.scan(/\b\w+\b/) - STOPWORDS
    self.keywords_text = keywords.join(' ')
  end
end
