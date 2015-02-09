class AddAuthorIdFieldToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :author_id, :integer, index: true
    add_foreign_key :articles, :authors
  end
end
