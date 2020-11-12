class DictionaryDefinition

	def initialize(url,credentials,errors)
		@url, @credentials, @errors = url,credentials,errors
	end

	def definition(word)
		@url.length > 1 ? url = @url[0]+URI.encode(word)+@url[1]: url = @url[0]+word
		response = Excon.get(
			url,
			headers: @credentials
		)
		if response.status != 200
			error = self.error_handler(response.status)
			return nil,error
		end
		return self.parse_definition(JSON.parse(response.body)),nil
	end

	def parse_definition(response)
		return response['results'][0]['lexicalEntries'][0]['entries'][0]['senses']
	end

	def error_handler(status)
		if @errors[status] != nil
			return @errors[status]
		else
			return "Something went wrong, please try again later"
		end
	end
end