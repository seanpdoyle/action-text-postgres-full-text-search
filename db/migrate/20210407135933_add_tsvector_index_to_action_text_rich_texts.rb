class AddTsvectorIndexToActionTextRichTexts < ActiveRecord::Migration[7.0]
  def change
    add_index :action_text_rich_texts,"to_tsvector('english', plain_text_body)", using: :gin, name: "tsvector_body_idx"
  end
end
