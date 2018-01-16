require_relative '../models/entry'

RSpec.describe Entry do
    describe "attributes" do
        
        let(:entry) { Entry.new('Anthony Martial','415.859.1124','Martial_11@gmail.com')}
        
        it "responds to name" do
            expect(entry).to respond_to(:name)
        end
        it "reports its name" do
            expect(entry.name).to eq('Anthony Martial')
        end
        it "responds to phone number" do
            expect(entry).to respond_to(:phone_number)
        end
        it "reports its phone number" do
            expect(entry.phone_number).to eq('415.859.1124')
        end
        it "reponds to email" do
            expect(entry).to respond_to(:email)
        end
        it "reports its email" do
            expect(entry.email).to eq('Martial_11@gmail.com')
        end
    end
    describe "#to_s" do
        
        let(:entry) { Entry.new('Paul Pogba','415.687.5495','Perfect_Pogba_6@gmail.com')}
        
        it "print info" do
            expected_string = "Name: Paul Pogba\nPhone: 415.687.5495\nEmail: Perfect_Pogba_6@gmail.com"
            expect(entry.to_s).to eq(expected_string)
        end
    end
end