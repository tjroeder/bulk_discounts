require 'rails_helper'

RSpec.describe HolidayService, type: :poro do
  let!(:service_1) { HolidayService.new }

  describe 'object' do
    it 'exists' do
      expect(service_1).to be_a(HolidayService)
    end
  end

  describe 'instance methods' do
    describe '#get_request' do
      it 'returns a hash if given correct URL' do
        VCR.use_cassette('holidays-2022-01-19') do
          example = service_1.get_request
          expect(example).to be_a(Array)
          expect(example[0][:localName]).to eq('Presidents Day')
          expect(example[0][:date]).to eq('2022-02-21')
        end
      end
    end
  end
end
