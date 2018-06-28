class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :pubDate
      t.string :title
      t.string :description
      t.string :link
      t.string :image_url
      t.string :image 
      t.string :content

      t.timestamps
    end
  end
end
