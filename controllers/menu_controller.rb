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
        puts "\nType \"Covfefe\" - to destroy all entries!"
        puts "\n"
        print "Enter your selection: "
        
        selection = gets.to_s.chomp
        
        case selection
            when "1"
                system "clear"
                view_all_entries
                main_menu
            when "2"
                system "clear"
                view_entry_number
                main_menu
            when "3"
                system "clear"
                create_entry
                main_menu
            when "4"
                system "clear"
                search_entries
                main_menu
            when "5"
                system "clear"
                read_csv
                main_menu
            when "0"
                system "clear"
                puts "See you again :D\nGlory Glory Man United!"
                exit(0)
            when "Covfefe"
                system "clear"
                nuke_by_real_donald_trump
                main_menu
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
        print "Please select an Entry number(or \"m\" to main menu): "
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
        confirm_entry("add",name, phone, email, nil)
    end
    
    def confirm_entry(method, name, phone, email, entry)
        
        puts "Please confirm your entry\nName: #{name}\nPhone Number: #{phone}\nEmail: #{email}"
        print "Is this entry correct? (Y/N): "
        confirm = gets.downcase.chomp
        
        case confirm
        
            when "y"
                if method == "add"
                    address_book.add_entry(name, phone, email)
                    system "clear"
                    puts "New entry has been created!"
                elsif method == "edit"
                    system "clear"
                    puts "Updated entry: "
                    puts entry
                end
            when "n"
                system "clear"
                if method == "add"
                    create_entry
                elsif method == "edit"
                    edit_entry(entry)
                end
            else
                system "clear"
                puts "Press \"Y\" for Yes or \"N\" for No"
                confirm_entry(method, name, phone, email, entry)
                
        end
    end
    
    def search_submenu(entry)
        # #12
        puts "\nd - delete entry"
        puts "e - edit this entry"
        puts "m - return to main menu"
        # #13
        selection = gets.chomp
        
        # #14
        case selection
            when "d"
                system "clear"
                delete_entry(entry)
                main_menu
            when "e"
                edit_entry(entry)
                system "clear"
                main_menu
            when "m"
                system "clear"
                main_menu
            else
                system "clear"
                puts "#{selection} is not a valid input"
                puts entry.to_string
                search_submenu(entry)
        end
    end
    
    def search_entries
        
        puts "s - Search all"
        puts "f - Search by firstname"
        puts "m - main_menu"
        print "=> "
        
        search_choice = gets.chomp
        case search_choice
            when "s"
                system "clear"
                print "Search all: "
                name = gets.chomp
                
                match = address_book.linear_search(name)
                
                if match
                    system "clear"
                    puts match.to_string
                    search_submenu(match)
                else
                    system "clear"
                    puts "No match found for #{name}"
                    search_entries
                end
            when "f"
                system "clear"
                print "Search by firstname: "
                name = gets.chomp
                
                match = address_book.search_firstname(name)
                
                if match
                    system "clear"
                    puts match.to_string
                    search_submenu(match)
                else
                    system "clear"
                    puts "No match found for #{name}"
                    search_entries
                end
            when "m"
                system "clear"
                main_menu
            else
                search_entries
        end
        
    end
    
    def read_csv
        print "Enter CSV file to import(file_name.csv): "
        file_name = gets.chomp
        
        if file_name.empty?
            system "clear"
            puts "No CSV file read"
            main_menu
        end
        
        begin
            entry_count = address_book.import_from_csv(file_name).count
            system "clear"
            puts "#{entry_count} new entries added from #{file_name}"
        rescue
            puts "#{file_name} is not a valid CSV file, please enter the name of the valid CSV file"
            read_csv
        end
    end
    
    def delete_entry(entry)
        address_book.entries.delete(entry)
        puts "#{entry.name} has been deleted!"
    end
    
    def edit_entry(entry)
        
        print "Updated name: "
        new_name = gets.chomp
        print "Updated phone number: "
        new_phone = gets.chomp
        print "Updated email: "
        new_email = gets.chomp
        
        entry.name = new_name if !new_name.empty?
        entry.phone_number = new_phone if !new_phone.empty?
        entry.email = new_email if !new_email.empty?
        system "clear"
        
        confirm_entry("edit",new_name,new_phone,new_email,entry)
        
    end
    
    def entry_submenu(entry)
        
        puts "n - next entry"
        puts "d - delete entry"
        puts "e - edit this entry"
        puts "m - return to main menu"
        print "Enter: "
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
                system "clear"
                delete_entry(entry)
                main_menu
            when "e"
                system "clear"
                edit_entry(entry)
                entry_submenu(entry)
            when "m"
                system "clear"
                main_menu
            else
                system "clear"
                puts "#{selection} is invalid"
                entry_submenu(entry)
        end
    end
    
    def nuke_by_real_donald_trump
       address_book.entries.clear
       puts "Destroy them by the Nuke!! Covfefe!\n@realDonaldTrump"
       puts "\n"
    end
end

