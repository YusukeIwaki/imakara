class TrackingDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  
  def id
    # JSON側にIDを直接見せることはないので
    raise StandardError.new("Something is wrong! You should use TrackingDecorator#id_code instead.")
  end
  
  def created_at
    object.created_at.to_i
  end
  
  def updated_at
    object.updated_at.to_i
  end
end
