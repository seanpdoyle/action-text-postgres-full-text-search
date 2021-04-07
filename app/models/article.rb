class Article < ApplicationRecord
  has_rich_text :content

  before_save { content.plain_text_body = content.body.to_plain_text }

  scope :with_content_containing, ->(query) { joins(:rich_text_content).merge(ActionText::RichText.where <<~SQL, "%" + query + "%") }
    plain_text_body ILIKE ?
  SQL
end
