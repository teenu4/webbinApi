module Scripts
  class DbRestore
    include Interactor

    def call
      ActiveRecord::Base.connection.tables.each do |table_name|
        ActiveRecord::Base.connection.reset_pk_sequence!(table_name)
      end
    end
  end
end
