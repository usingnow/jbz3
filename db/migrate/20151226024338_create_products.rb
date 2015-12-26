class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|

      t.string    :name
      t.text      :description
      t.string    :image_url
      t.integer   :insurance_cycle
      t.integer   :age_starts_at
      t.integer   :age_ends_at

      t.text      :benifit
      t.text      :acknowledgement
      t.text      :recommendation

      t.timestamps null: false
    end
  end
end