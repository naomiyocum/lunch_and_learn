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

  def self.user_creation_error(errors)
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

  def self.missing_params
    {
      'errors': [
        {
          "status": 'PLEASE TRY AGAIN',
          "message": "Make sure to include all necessary params",
          "code": 400
        }
      ]
    }
  end

  def self.incorrect_password
    {
      'errors': [
        {
          "status": 'PLEASE TRY AGAIN',
          "message": "Incorrect password",
          "code": 400
        }
      ]
    }
  end
end