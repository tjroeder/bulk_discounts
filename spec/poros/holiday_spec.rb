require 'rails_helper'

RSpec.describe Holiday, type: :poro do
  let!(:holiday) do
    data = {localName: 'Presidents Day', date: '2022-02-21'}

    Holiday.new(data)
  end

  describe 'object' do
    it 'exists' do     
      expect(holiday).to be_a(Holiday)
    end
  end

  describe 'attributes' do
    it 'has name, and date' do
      expected = {localName: 'Presidents Day', date: '2022-02-21'}

      expect(holiday).to have_attributes(name: expected[:localName])
      expect(holiday).to have_attributes(date: expected[:date])
    end
  end
end
