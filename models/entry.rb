class Entry
    
    attr_accessor :name, :phone_number, :email
    
    def initialize(name, phone_number, email)
       @name, @phone_number, @email = name, phone_number, email 
    end
    
    def to_string
        "Name: #{name}\nPhone: #{phone_number}\nEmail: #{email}"
    end
    
end
