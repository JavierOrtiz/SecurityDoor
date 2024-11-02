class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.text :content
      t.boolean :is_scam, default: false
      t.boolean :analyzed, default: false
      t.text :recommendations
      t.text :reasons
      t.string :url
      t.string :domain
      t.string :entity
      t.string :subject
      t.text :keywords, array: true, default: []
      t.text :keywords_text

      t.timestamps
    end

    add_index :reports, :keywords, using: 'gin'

    execute "CREATE EXTENSION IF NOT EXISTS pg_trgm;"
    add_index :reports, :keywords_text, using: 'gin', opclass: :gin_trgm_ops
  end
end