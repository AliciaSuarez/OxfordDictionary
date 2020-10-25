$last_words=[]
class DictionaryController < ApplicationController
  def index
  end

  def search
    words,error = find_word(params[:word])
    unless words
      flash[:alert] = error
      return render action: :index
    end
    flash[:alert] = nil
    addWordList(params[:word])
    @title=params[:word]
    @word = words['results'][0]['lexicalEntries'][0]['entries'][0]['senses']
    return render action: :index
  end

  def addWordList(word)
    if !($last_words.include?(word))
      if $last_words.length < 5
        $last_words.push(word)
      else
        $last_words= $last_words.slice(1,5).push(word)
      end
    end
  end

  def error_handler(status)
    case status
      when 404
        "No entry was found matching the selection parameters"
      when 500
        "Internal error. An error occurred during processing"
      when 504 
        "Timeout Error: Service unaveilable"
      else 
        "Something went wrong, please try again later"
    end
  end

  private
  def request_api(url)
    response = Excon.get(
      url,
      headers: {
        'Accept'=> 'application/json',
        'app_id' => ENV["APP_ID"],
        'app_key' => ENV["APP_KEY"]
      }
    )
    if response.status != 200
      error = error_handler(response.status)
      return nil,error
    end
    return JSON.parse(response.body),nil
  end

  def find_word(word)
    request_api(
      "https://od-api.oxforddictionaries.com/api/v2/entries/en-us/#{URI.encode(word)}?fields=definitions&strictMatch=false"
    )
  end

end