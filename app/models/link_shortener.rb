class LinkShortener < ApplicationRecord
    validates_presence_of :long_url
    validates_uniqueness_of :long_url
    validates :long_url, format: {with: /\A(https|http)\:\/\/(\S+)(\.com)\/.*\z/}
    validates :alias, length: {maximum: 50, too_long: 'Maximum %{count} characters allowed'}
    validates_uniqueness_of :alias
    before_save :generate_shortend_url

    def save_shortend_url(url:, url_alias:)
        begin
            self.long_url = url
            self.alias = url_alias
            self.save!
            return {success: true, shortend_url: shortend_url}
        rescue Exception => e
            return {success: true, shortend_url: shortend_url} if e.to_s =~ /Alias has already been taken/
            return {error: true, message: e.to_s}
        end
    end

    private
    
    def generate_shortend_url
        self.alias = self.alias.present? ? self.alias : SecureRandom.uuid[0...9]
    end

    def shortend_url
        "http://localhost:3001/"+self.alias
    end
end
