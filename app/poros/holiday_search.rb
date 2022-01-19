class HolidaySearch
  attr_reader :service
              
  def initialize
    @service = HolidayService.new
  end

  def holidays_info
    holiday_service = @service.get_request
    holiday_service.map.with_index do |data, index|
      exit if index = 3
      Holiday.new(data)
    end
  end
end