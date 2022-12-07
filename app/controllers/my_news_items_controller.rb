# frozen_string_literal: true

require 'news-api'

class MyNewsItemsController < SessionController
  before_action :set_representative
  before_action :set_representatives_list
  before_action :set_news_item, only: %i[edit update destroy]

  def new
    @news_item = NewsItem.new
  end

  def edit; end

  def select_representative_issue
    news_api_key = Rails.application.credentials[:NEWS_API_KEY]
    newsapi = News.new(news_api_key)
    representative = Representative.find(params[:news_item][:representative_id])
    keywords_to_search = "#{representative.name} AND #{params[:news_item][:issue]}"
    top_five_articles = newsapi.get_everything(q:        keywords_to_search,
                                               language: 'en',
                                               sortBy:   'popularity',
                                               pageSize: 5)
    session[:top_five_articles] = top_five_articles
    session[:news_item] = params[:news_item]
    redirect_to representative_second_page_path(params[:news_item][:representative_id])
  end

  def second_page
    form_news_item = session[:news_item]
    @representative = Representative.find(form_news_item[:representative_id])
    @issue = form_news_item[:issue]
    @articles = session[:top_five_articles]
    @news_item = NewsItem.new
    if form_news_item[:from_first]
      flash.clear
      nil
    elsif !form_news_item[:all_info].nil? or !form_news_item[:rating].nil?
      redirect_to rate_my_news_item_path
    else
      flash[:failure] = 'Article not rated! Please select an article and a rating.'
    end
  end

  def rate
    form_news_item = session[:news_item]
    flash[:success] = 'Article successfully rated!'
    attr_hash = article_attrs(form_news_item[:all_info], form_news_item[:rating])
    rating = Current.user.ratings.find_by(title: attr_hash[:title], link: attr_hash[:link],
                                          description: attr_hash[:description])
    if rating.nil?
      Current.user.ratings.create(title: attr_hash[:title], link: attr_hash[:link],
                                  description: attr_hash[:description],
                                  rating: attr_hash[:rating])
    else
      rating.rating = attr_hash[:rating]
      rating.save
    end
    redirect_to user_articles_path
  end

  def create
    @news_item = NewsItem.new(news_item_params)
    if @news_item.save
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully created.'
    else
      render :new, error: 'An error occurred when creating the news item.'
    end
  end

  def update
    if @news_item.update(news_item_params)
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully updated.'
    else
      render :edit, error: 'An error occurred when updating the news item.'
    end
  end

  def destroy
    @news_item.destroy
    redirect_to representative_news_items_path(@representative),
                notice: 'News was successfully destroyed.'
  end

  private

  def set_representative
    @representative = Representative.find(
      params[:representative_id]
    )
  end

  def set_representatives_list
    @representatives_list = Representative.all.map { |r| [r.name, r.id] }
  end

  def set_news_item
    @news_item = NewsItem.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def news_item_params
    params.require(:news_item).permit(:news, :title, :description, :link, :representative_id, :rating, :all_info)
  end

  def article_attrs(all_info, rating)
    article_title = all_info.split(/(?=https)/)[0]
    rest_of_string = all_info.split(/(?=https)/)[1]
    article_link = rest_of_string.split[0]
    rest_of_string.slice!(article_link)
    article_description = rest_of_string
    article_rating = rating.to_i
    { title: article_title, link: article_link, description: article_description, rating: article_rating }
  end
end
