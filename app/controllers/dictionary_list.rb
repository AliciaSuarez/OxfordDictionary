require 'dictionary_list'

module DictionaryList
  oxford_url= ["https://od-api.oxforddictionaries.com/api/v2/entries/en-us/","?fields=definitions&strictMatch=false"]
  oxford_credentials = {
    'Accept'=> 'application/json',
    'app_id' => '2676114d',
    'app_key' => '3f9da88cb37efcd09018b80409ed5b44'
  }
  oxford_errors = {
    404 =>"No entry was found matching the selection parameters",
    500 => "Internal error. An error occurred during processing",
    504 => "Timeout Error: Service unaveilable"
  }
  OXF = DictionaryDefinition.new(oxford_url,oxford_credentials,oxford_errors)

  end