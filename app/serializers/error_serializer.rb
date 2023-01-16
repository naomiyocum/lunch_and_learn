class ErrorSerializer
  def self.invalid_country
    {
      'errors': [
        {
          "status": 'INVALID COUNTRY',
          "message": "This is not a country, please try again",
          "code": 400
        }
      ]
    }
  end

  def self.user_error(errors)
    {
      'errors': [
        {
          "status": 'PLEASE TRY AGAIN',
          "message": "#{errors.full_messages.to_sentence}",
          "code": 400
        }
      ]
    }
  end

  def self.user_not_found
    {
      'errors': [
        {
          "status": 'PLEASE TRY AGAIN',
          "message": "User does not exist",
          "code": 400
        }
      ]
    }
  end

  def self.favorite_not_found
    {
      'errors': [
        {
          "status": 'PLEASE TRY AGAIN',
          "message": "Favorite does not exist",
          "code": 400
        }
      ]
    }
  end
end