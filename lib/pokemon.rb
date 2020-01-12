class Pokemon
    attr_accessor :name, :type, :db
    attr_reader :id 

    def initialize(id:nil, name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @db = db
    end 

    def self.save(name, type, db)
        sql = <<-SQL
        INSERT INTO pokemon (name, type)
        VALUES (?, ?);
        SQL

        db.execute(sql, name, type)

        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end 

    def self.find(id, db)
        sql = <<-SQL
        SELECT * 
        FROM pokemon 
        WHERE id = id
        SQL

        db.execute(sql).map do |row|
            new_pokemon = self.new(id: id, name: row[1], type: row[2], db: db)
            new_pokemon
        end.first 
    end

end
