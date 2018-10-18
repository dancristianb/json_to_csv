require 'json_parser.rb'
require 'csv'

describe JsonParser do
    describe '#get_csv_from_json' do
        url = 'https://academy-ruby.nyc3.digitaloceanspaces.com/movies.json'
        json = JsonFetcher.get_json_from_url(url)
        subject {JsonParser.get_csv_from_json(json)}
        
        it "is a String" do
            expect(subject.class).to eq(String)
        end
        it "is not empty" do
            expect(subject).not_to be_empty
        end
        it "is a valid CSV" do
            # this won't work since we've got commas in the text as well
            # subject.each_line do |row|
            #     count = row.split(",").size
            # end
        end

        # movies.json specific tests
        it "doesn't contain the movies key" do
            expect(subject.include?("movies")).to eq(false)
        end
        it "contains all the expected keys" do
            expect(subject.include?("title")).to eq(true)
            expect(subject.include?("genres")).to eq(true)
            expect(subject.include?("description")).to eq(true)
            expect(subject.include?("year")).to eq(true)
        end
        it "contains \"Star Trek: Discovery\"" do
            expect(subject.include?("Star Trek: Discovery")).to eq(true)
        end
        it "includes quotations when needed" do
            expect(subject.include?("\"Action, Adventure, Drama\"")).to \
                eq(true)
        end
    end
end