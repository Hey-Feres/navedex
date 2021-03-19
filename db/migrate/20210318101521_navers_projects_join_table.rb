class NaversProjectsJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :navers, :projects do |t|
      t.index :naver_id
      t.index :project_id
    end
  end
end
