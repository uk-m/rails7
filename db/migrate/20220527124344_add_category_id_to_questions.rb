class AddCategoryIdToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :category_id, :integer
  end
end
