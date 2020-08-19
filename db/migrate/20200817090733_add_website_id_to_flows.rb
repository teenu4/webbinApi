class AddWebsiteIdToFlows < ActiveRecord::Migration[6.0]
  def change
    add_reference :flows, :website, index: true
  end
end
