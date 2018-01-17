require_relative 'entry'
require 'csv'

class AddressBook
   attr_reader :entries
   
    def initialize
        @entries = []
    end
   
    def add_entry(name, phone_number, email)

        index = 0
        entries.each do |entry|
            
            if name < entry.name
                break
            end
            index+= 1
        end
        entries.insert(index, Entry.new(name, phone_number, email))
    end
    
    def remove_entry(name, phone_number, email)
        
        index = 0
        entries.each do |entry|
            
            if name == entry.name
                entries.delete_at(index)
                break
            end
            index+= 1
        end
    end
    
    def import_from_csv(file_name)
        
        csv_text = File.read(file_name)
        csv = CSV.parse(csv_text, headers: true, skip_blanks: true)
        
        csv.each do |row|
            row_hash = row.to_hash
            add_entry(row_hash["name"], row_hash["phone_number"],row_hash["email"])
        end
    end
    
    #This is iterarive search
    def linear_search(input)
        
        search_name = input.downcase.split(' ')
        search_name.each do |name_el|
            
            entries.each do |entry|
                
                name_array = entry.name.downcase.split(' ')
                
                if name_array.include?(name_el)
                    return entry
                end
            end
        end
        return nil
    end
    
    #This is binary search
    def search_firstname(input)
        
        search_name = input.downcase
        lower = 0
        upper = entries.length - 1
        
        while lower<= upper
            mid = (upper+lower)/2
            mid_name_array = entries[mid].name.split(' ').map! { |el| el.downcase }
            
            if search_name == mid_name_array[0]
                return entries[mid]
            elsif search_name < mid_name_array[0]
                upper = mid - 1
            elsif search_name > mid_name_array[0]
                lower = mid + 1
            end
        end
        return nil
    end
end
