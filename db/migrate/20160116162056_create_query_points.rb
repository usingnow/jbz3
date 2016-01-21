class CreateQueryPoints < ActiveRecord::Migration
  def change
    create_table :query_points do |t|
      t.string :creditcard_num
      t.text :request
      t.text :response

      t.timestamps null: false
    end

    add_reference :query_points, :order, index: true, foreign_key: true
    add_reference :query_points, :user, index: true, foreign_key: true
  end
end
