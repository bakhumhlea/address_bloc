require_relative '../models/address_book'
 
RSpec.describe AddressBook do
    
    let(:book) {AddressBook.new}
    
    def check_entry(entry, expected_name, expected_number, expected_email)
        expect(entry.name).to eq expected_name
        expect(entry.phone_number).to eq expected_number
        expect(entry.email).to eq expected_email
    end
    
    describe "attributes" do
        it "responds to entries" do
            book = AddressBook.new
            expect(book).to respond_to(:entries)
        end
        it "initializes entries as an array" do
            expect(book.entries).to be_an(Array)
        end
 
        it "initializes entries as empty" do
            expect(book.entries.size).to eq(0)
        end
    end
    
    describe "#add_entry" do
        
        it "adds only one entry to the address book" do
            book.add_entry('Paul Pogba','415.687.5495','perfect_pogba_6@gmail.com')
            
            expect(book.entries.size).to eq(1)
        end
        
        it "adds the correct information to entries" do
            book.add_entry('Paul Pogba','415.687.5495','perfect_pogba_6@gmail.com')
            new_entry = book.entries[0]
            
            expect(new_entry.name).to eq('Paul Pogba')
            expect(new_entry.phone_number).to eq('415.687.5495')
            expect(new_entry.email).to eq('perfect_pogba_6@gmail.com')
        end
    end
    
    describe "#remove_entry" do
       
        it "remove entry from address book" do
            book.add_entry('Paul Pogba','415.687.5495','perfect_pogba_6@gmail.com')
            book.remove_entry('Paul Pogba','415.687.5495','perfect_pogba_6@gmail.com')
            expect(book.entries.size).to eq(0)
        end
    end
    
    describe "#import_from_csv" do
        
        it "imports the correct number of entries" do
            book.import_from_csv("entries.csv")
            book_size = book.entries.size
            expect(book_size).to eq 5
        end
        
        it "imports the correct number of entries" do
            book.import_from_csv("entries_2.csv")
            book_size = book.entries.size
            expect(book_size).to eq 3
        end
        
        it "import the 1st entry" do
            book.import_from_csv("entries.csv")
            entry_one = book.entries[0]
            check_entry(entry_one, "Ander Herrera", "555-555-4854", "herrera_21@blocmail.com")
        end
        
        it "imports the 2nd entry" do
            book.import_from_csv("entries.csv")
            entry_two = book.entries[1]
            check_entry(entry_two, "Anthony Martial", "555-555-5415", "martial_11@blocmail.com")
        end
     
        it "imports the 3rd entry" do
            book.import_from_csv("entries.csv")
            entry_three = book.entries[2]
            check_entry(entry_three, "Juan Mata", "555-555-3660", "juan_8_mata@blocmail.com")
        end
     
        it "imports the 4th entry" do
            book.import_from_csv("entries.csv")
            entry_four = book.entries[3]
            check_entry(entry_four, "Paul Pogba", "555-555-4646", "pogba_6@blocmail.com")
        end
     
        it "imports the 5th entry" do
            book.import_from_csv("entries.csv")
            entry_five = book.entries[4]
            check_entry(entry_five, "Scott McTominay", "555-555-2036", "mctominay_39@blocmail.com")
        end
        
        it "imports the 1st entry of entries_2 file" do
            book.import_from_csv("entries_2.csv")
            entry_three = book.entries[0]
            check_entry(entry_three, "Jessie Lingard", "555-555-2038", "lingard_14@blocmail.com")
        end
        
        it "imports the 2st entry of entries_2 file" do
            book.import_from_csv("entries_2.csv")
            entry_three = book.entries[1]
            check_entry(entry_three, "Luke Shaw", "555-555-2438", "shaw_23@blocmail.com")
        end
        
        it "imports the 3st entry of entries_2 file" do
            book.import_from_csv("entries_2.csv")
            entry_three = book.entries[2]
            check_entry(entry_three, "Nemanja Matic", "555-555-3038", "matic_31@blocmail.com")
        end
    end
end