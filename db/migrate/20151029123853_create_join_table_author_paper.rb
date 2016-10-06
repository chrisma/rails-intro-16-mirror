class CreateJoinTableAuthorPaper < ActiveRecord::Migration
  def change
    create_join_table :Authors, :Papers do |t|
      # t.index [:author_id, :paper_id]
      # t.index [:paper_id, :author_id]
    end
  end
end
