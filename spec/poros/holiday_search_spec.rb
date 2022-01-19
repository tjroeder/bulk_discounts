require 'rails_helper'

RSpec.describe HolidaySearch, type: :poro do
  let!(:search_1) { HolidaySearch.new }

  describe 'object' do
    it 'exists' do
      expect(search_1).to be_a(HolidaySearch)
    end
  end

  describe 'attributes' do
    it 'has service' do
      expect(search_1.service).to be_a(HolidayService)
    end
  end

  describe 'instance methods' do
    describe '#holiday_info' do
      it 'creates array of three Holiday objects' do
        VCR.use_cassette('holidays-2022-01-19') do
          holidays = search_1.holidays_info
          
          expect(holidays.first).to be_a(Holiday)
          expect(holidays).to be_a(Array)
          expect(holidays.count).to eq(3)
        end
      end
    end
  end
end
