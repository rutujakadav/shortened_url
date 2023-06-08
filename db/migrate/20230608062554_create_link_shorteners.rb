class CreateLinkShorteners < ActiveRecord::Migration[5.2]
  def change
    create_table :link_shorteners do |t|
      t.text :long_url
      t.string :alias
      t.timestamps
    end
  end
end
