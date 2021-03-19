class CreateNavers < ActiveRecord::Migration[6.0]
  def change
    create_table :navers do |t|
      t.string :name
      t.date :birthdate
      t.date :admission_date
      t.string :job_role

      t.timestamps
    end
  end
end
