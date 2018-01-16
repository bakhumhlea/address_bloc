require_relative '../models/address_book'

class MenuController
    attr_reader :address_book
    
    def initialize
        @address_book = AddressBook.new
    end
    
    def main_menu
        
        puts "Main Menu - #{address_book.entries.count} entries"
        puts "1 - View all entries"
        puts "2 - View entry by number"
        puts "3 - Create an entry"
        puts "4 - Search for an entry"
        puts "5 - Import entries from a CSV"
        puts "0 - Exit"
        print "Enter your selection: "
        
        selection = gets.to_i
        
        case selection
            when 1
                system "clear"
                view_all_entries
                main_menu
            when 2
                system "clear"
                view_entry_number
                main_menu
            when 3
                system "clear"
                create_entry
                main_menu
            when 4
                system "clear"
                search_entries
                main_menu
            when 5
                system "clear"
                read_csv
                main_menu
            when 0
                puts "Good-Bye Haha Yo!"
                exit(0)
            else
                system "clear"
                puts "Sorry, that is not a valid inout\nTry Again :)"
                main_menu
        end
            
    end
    
    def view_all_entries
        address_book.entries.each do |entry|
            system "clear"
            puts entry.to_string
            
            entry_submenu(entry)
        end
        
        system "clear"
        puts "End of entries"
    end
    
    def view_entry_number
        system "clear"
        entries = address_book.entries
        
        if entries.size == 0
            puts "AddressBloc is Empty!"
            print "Do you want to create a new entry? (Y/N): "
            answer = gets.downcase.chomp
            case answer
                when "y"
                    system "clear"
                    create_entry
                when "n" || ""
                    system "clear"
                    main_menu
                else
                    system "clear"
                    view_entry_number
            end
            main_menu
        end
        
        entries.each_with_index do |entry, index|
            puts "#{index+1} - #{entry.name.to_s}"
        end
        puts "m - return to main menu"
        print "Please select an Entry number: "
        number = gets.to_i
        
        case number
            when 0
                system "clear"
                main_menu
            when 1..entries.size
                system "clear"
                n = number
                puts entries[n-1].to_string
                if n-1 == entries.size-1
                    puts "This is last entry"
                end
                entry_submenu(entries[n-1])
            else
                system "clear"
                puts "Invalid Input!"
                view_entry_number
        end
    end
    
    def create_entry
        
        system "clear"
        puts "New AddressBloc entry"
        print "Name: "
        name = gets.chomp
        print "Phone Number: "
        phone = gets.chomp
        print "Email: "
        email = gets.chomp
        
        system "clear"
        confirm_entry(name, phone, email)
    end
    
    def confirm_entry(name, phone, email)
        
        puts "Please confirm your entry\nName: #{name}\nPhone Number: #{phone}\nEmail: #{email}"
        print "Is this entry correct? (Y/N): "
        confirm = gets.downcase.chomp
        
        case confirm
        
            when "y"
                address_book.add_entry(name, phone, email)
                system "clear"
                puts "New entry has been created!"
            when "n"
                system "clear"
                create_entry
            else
                system "clear"
                puts "Please confirm your entry.."
                puts "press \"Y\" or \"N\" key and then press Enter!"
                confirm_entry(name,phone,email)
                
        end
    end
    
    def search_entries
        p "Search"
    end
    
    def read_csv
        p "Read"
    end
    
    def entry_submenu(entry)
        
        puts "n - next entry"
        puts "d - delete entry"
        puts "e - edit this entry"
        puts "m - return to main menu"
        
        selection = gets.downcase.chomp
        
        case selection
        
            when "n" || nil
                i = address_book.entries.index(entry)
                system "clear"
                if i+1 < address_book.entries.size
                    puts address_book.entries[i+1].to_string
                    entry_submenu(address_book.entries[i+1])
                else
                    puts "End of entries"
                    main_menu
                end
            when "d"
                
            when "e"
                
            when "m"
                system "clear"
                main_menu
            else
                system "clear"
                puts "#{selection} is invalid"
                entry_submenu(entry)
        end
    end
end

