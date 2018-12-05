module Api
    module V1
        class ArticlesController < ApplicationController
            def index
                articles = Article.order('created_at DESC');
                render json: {status: 'SUCESS', message: 'Loaded articles', data: articles}, status: :ok
            end

            def show
                article = Article.find(params[:id])
                render json: {status: 'SUCESS', message: 'Loaded article', data: article}, status: :ok
            end

            def create
                article = Article.new(article_params)

                if article.save 
                    render json: {status: 'SUCESS', message: 'Article saved', data: article}, status: :ok 
                else
                    render json: {status: 'ERROR', message: 'Article NOT saved', data: article.errors}, status: :unprocessable_entity
                end
            end

            def destroy
                article = Article.find(params[:id])
                article.destroy
                render json: {status: 'SUCESS', message: 'Article deleted', data: article}, status: :ok 
            end

            def update
                article = Article.find(params[:id])
                if article.update_attributes(article_params)
                    render json: {status: 'SUCESS', message: 'Article updated', data: article}, status: :ok 
                else
                    render json: {status: 'ERROR', message: 'Article NOT updated', data: article.errors}, status: :unprocessable_entity
                end
            end

            private

            def article_params
                params.permit(:title, :body)
            end

        end
    end
end