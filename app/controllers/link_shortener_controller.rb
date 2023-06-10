class LinkShortenerController < ApplicationController
    before_action :authenticate, only: [:url_shortener]

    def url_shortener
        authenticate
        return render json: {error: 'Invalid params', status: 400} unless url_shortener_params.present?
        res = LinkShortener.new.save_shortend_url(url: params[:url], url_alias: params[:alias])
        render json: res
    end

    def redirect_to_og_url
        url_alias = params[:alias].gsub(URI.parse(params[:alias]).host.to_s, '').gsub(/(http|https)\:\/\//, '')
        record = LinkShortener.find_by_alias(url_alias)
        render staus: 404 unless record.present?
        redirect_to record.long_url
    end

    private

    def url_shortener_params
        params.permit(:url, :alias)
    end
end
