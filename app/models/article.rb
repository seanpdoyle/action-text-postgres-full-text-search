class Article < ApplicationRecord
  has_rich_text :content

  scope :with_content_containing, ->(query) { joins(:rich_text_content).merge ActionText::RichText.with_body_containing(query) }
end
