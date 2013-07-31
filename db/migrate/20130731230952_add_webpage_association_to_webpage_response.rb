class AddWebpageAssociationToWebpageResponse < ActiveRecord::Migration
  def change
    add_reference :webpage_responses, :webpage, index: true,
                  after: :webpage_request_id
  end
end
