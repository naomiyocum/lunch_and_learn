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
end