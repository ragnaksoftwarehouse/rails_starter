class SystemService < AbstractService

	LANGS = [{:name => "English", :val => "en"}, {:name => "Polski", :val => "pl"}]
	TRACKERS_BRANDS = [{:name => "Teltonicka", :val => "teltonicka"}, {:name => "Albatros", :val => "albatros"}]
	ROAMING = [{:name => "On", :val => true}, {:name => "Off", :val => false}]
	VEHS_ICONS = [
		{:name => "default", :val => "Default"}
	]

	def set_lang(params, user)
		lang = "pl"
		if user.nil?
			lang = params[:locale] || "pl"
		else
			lang = user.lang
		end

		if ["pl", "en"].include?(lang)
			I18n.locale = lang 
		else
			I18n.locale = "pl"
		end

		puts I18n.locale
	end

end
