require 'json_parser.rb'

describe JsonFetcher do
    describe '#get_json_from_url' do
        url = 'https://academy-ruby.nyc3.digitaloceanspaces.com/movies.json'
        subject {JsonFetcher.get_json_from_url(url)}
        
        it "is not empty" do
            expect(subject).not_to be_empty
        end
    end
end