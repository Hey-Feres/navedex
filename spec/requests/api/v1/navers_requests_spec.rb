require 'rails_helper'

RSpec.describe 'API V1 Navers', type: :request do
  let(:user) { create(:user) }

  context 'GET /navers' do
    let(:url) { '/api/v1/navers' }
    let!(:navers) { create_list(:naver, 20) }

    context 'without any params' do
      it 'returns 20 Navers' do
        get url, headers: auth_header(user)

        expect(body_json.dig('data').count).to eq(20)
      end

      it 'returns 20 first Navers' do
        get url, headers: auth_header(user)

        expected_navers_ids = navers[0..19].as_json.map{|i| i.dig('id')}
        result_navers_id = body_json.dig('data').map{ |i| i.dig('id').to_i }
        expect(result_navers_id).to eq(expected_navers_ids)
      end

      it 'returns success status' do
        get url, headers: auth_header(user)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with search[name] param' do
      let!(:search_name_navers) { FactoryBot.create_list(:naver, 15) }

      let(:naver) { search_name_navers.sample }
      let(:search_params) { { search_by: 'name', search_for: naver.name } }

      it 'returns only seached navers limited by default pagination' do
        get url, headers: auth_header(user), params: search_params

        expected_naver = naver.as_json(only: %i(id name birthdate admission_date job_role)).merge({'projects' => naver.projects.to_a})
        received_naver = body_json.dig('data').first.dig('attributes').transform_keys{|key| key.tr('-', '_')}.merge({ 'id' => body_json.dig('data').first.dig('id').to_i })

        expect(received_naver).to eq(expected_naver)
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

      it 'returns ordered navers limited by default pagination' do
        get url, headers: auth_header(user), params: order_params
        navers.sort! { |a, b| b[:name] <=> a[:name]}

        expected_navers = navers[0..19].as_json(only: %i(name))
        received_navers = body_json.dig('data').map{|naver| naver.dig('attributes').slice('name')}

        expect(received_navers).to contain_exactly(*expected_navers)
      end

      it 'returns success status' do
        get url, headers: auth_header(user), params: order_params
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
