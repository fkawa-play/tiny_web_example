# -*- coding: utf-8 -*-

require 'yaml'
require 'spec_helper'

describe 'Webapi Integration spec' do
  before do
    webapi_config = YAML.load_file(File.expand_path('./config/webapi.conf'))
    WebAPIClient.uri = webapi_config["uri"]
  end

  let(:comment_params) do
    {
      display_name: "webapitest",
      comment: "webapi sample message",
    }
  end

  let(:comment) { WebAPIClient::Comment.create(comment_params) }

  describe 'post' do
    it 'create a new comment' do
      res = WebAPIClient::Comment.create(comment_params)
      expect(res["display_name"]).to eq comment_params[:display_name]
    end
  end

  describe 'get' do
    it 'show list for the comments' do
      res = WebAPIClient::Comment.index
      expect(res).to be_a(Array)
    end

    it 'show detail the comment' do
      res = WebAPIClient::Comment.show(comment["id"])
      expect(res["id"]).to eq comment["id"]
    end
  end

  describe 'update' do
    before do
      comment_params[:comment] = "webapi sample message 2"
    end
    it 'update api not allowed' do
      res = WebAPIClient::Comment.update(comment["id"], comment_params)
      expect(res["code"]).to eq 405
    end
  end

  describe 'delete' do
    it 'delete api not allowed' do
      res = WebAPIClient::Comment.delete(comment["id"])
      expect(res["code"]).to eq 405
    end
  end
end
