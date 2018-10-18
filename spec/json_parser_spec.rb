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
            # expect(subject).to eq(String)
        end
    end
end