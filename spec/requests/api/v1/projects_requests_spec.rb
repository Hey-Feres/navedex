require 'rails_helper'

RSpec.describe 'API V1 Projects', type: :request do
  let(:user) { create(:user) }

  context 'GET /projects' do
    let(:url) { '/api/v1/projects' }
    let!(:projects) { create_list(:project, 20) }

    context 'without any params' do
      it 'returns 20 Projects' do
        get url, headers: auth_header(user)

        expect(body_json.dig('data').count).to eq(20)
      end

      it 'returns 20 first Projects' do
        get url, headers: auth_header(user)

        expected_projects_ids = projects[0..19].as_json.map{|i| i.dig('id')}
        result_projects_id = body_json.dig('data').map{ |i| i.dig('id').to_i }
        expect(result_projects_id).to eq(expected_projects_ids)
      end

      it 'returns success status' do
        get url, headers: auth_header(user)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with search[name] param' do
      let!(:search_name_projects) { create_list(:project, 15) }

      let(:project) { search_name_projects.sample }
      let(:search_params) { { search_by: 'name', search_for: project.name } }

      it 'returns only searched projects limited by default pagination' do
        get url, headers: auth_header(user), params: search_params

        received_project = body_json.dig('data').first.dig('attributes').merge({ 'id' => body_json.dig('data').first.dig('id').to_i }).dig('name').split(' ')

        expect(received_project).to include(project.name)
      end

      it 'returns success status' do
        get url, headers: auth_header(user), params: search_params
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with pagination params' do
      let(:page) { 2 }
      let(:length) { 5 }

      let(:pagination_params) { { page: page, length: length } }

      it 'returns records sized by :length' do
        get url, headers: auth_header(user), params: pagination_params
        expect(body_json.dig('data').count).to eq(length)
      end

      it 'returns success status' do
        get url, headers: auth_header(user), params: pagination_params
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with order params' do
      let(:order_params) { { sort_by: 'name', order_by: 'desc' } }

      it 'returns ordered projects limited by default pagination' do
        get url, headers: auth_header(user), params: order_params
        projects.sort! { |a, b| b[:name] <=> a[:name]}

        expected_projects = projects[0..19].as_json(only: %i(name))
        received_projects = body_json.dig('data').map{|naver| naver.dig('attributes').slice('name')}

        expect(received_projects).to contain_exactly(*expected_projects)
      end

      it 'returns success status' do
        get url, headers: auth_header(user), params: order_params
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
