class Company < ApplicationRecord
	validates_presence_of :name
	before_save :do_before_save

	has_many :users
	
	def self.allowed_fields(params)
		return params.require(:company).permit(
			:name
		)
	end

	private
		def do_before_save
			if self.valid? && !self.name.blank?
				ret = self.name.downcase
				ret.gsub! /['`]/,""
				ret.gsub! /\s*@\s*/, "-"
				ret.gsub! /\s*&\s*/, "-"
				ret.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '-'  
				ret.gsub! /_+/,"-"
				ret.gsub! /\A[_\.]+|[_\.]+\z/,""
				self.slug = ret

				existing = Company.all.where(:slug => self.slug).first
				if !existing.nil? && (self.id.blank? || existing.id != self.id)
					self.errors.add(:name, "Name should be unique")
					raise ValidationErrorService.new(self)
				end
			end
		end
end
