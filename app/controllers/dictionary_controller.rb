require 'dictionary_list' 
$last_words=[]

class DictionaryController < ApplicationController
  include DictionaryList

  def index
  end

  def search

    case params[:dictionary]
    when "Oxford"
      @definitions,error = OXF.definition(params[:word])
    when "Wikipedia"
      #complete
    when "Merriam-Webster"
      #complete
    when "Cambridge"
      #complete
    else
      flash[:alert] = "you must select a Dictionary"
      return render action: :index
    end

    unless @definitions
      flash[:alert] = error
      return render action: :index
    end
    flash[:alert] = nil
    addWordList(params[:word].capitalize())
    @title=params[:word].capitalize()
    @dictionary=params[:dictionary]
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

end