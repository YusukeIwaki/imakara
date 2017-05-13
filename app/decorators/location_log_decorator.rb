class LocationLogDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  
  def attributes_for_json_response
    {
      id: object.id,
      lat: lat,
      lon: lon,
      accuracy: accuracy,
      created_at: created_at
    }
  end
  
  def lat
    object.lat.to_f
  end
  
  def lon
    object.lon.to_f
  end
  
  def accuracy
    object.accuracy.to_f
  end
  
  def created_at
    object.created_at.to_i
  end
end
