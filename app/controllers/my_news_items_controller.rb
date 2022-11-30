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
    params[:top_five_articles] = top_five_articles
    # redirect_to representative_second_page_path - uncomment when you implement view
  end

  def second_page
    # implement second page controller here - route setup already
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
    params.require(:news_item).permit(:news, :title, :description, :link, :representative_id)
  end
end
