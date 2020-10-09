class ImagesCountQuery
  class << self
    def call(type, where, joins)
      ActiveRecord::Base.connection.execute(query(type, where, joins))
    end

    private

    def query(type, where, joins)
      <<-SQL
select #{type}, count(i.id)
from images i
#{joins}
#{where}
group by #{type};
      SQL
    end
  end
end