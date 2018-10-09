class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.varchar :title
      t.integer :pages
      t.integer﻿ :year
    end
  end
end
