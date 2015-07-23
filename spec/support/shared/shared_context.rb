shared_context 'no auth needed' do
  let :oauth_client do
    response = double(OAuth2::Response, parsed: {blub: "gach"})
    double(OAuth2::Client, get: response)
  end

  before :each do
    allow(controller).to receive(:auth_needed?).and_return(false)
    allow(controller).to receive(:access_token).and_return(oauth_client)
  end
end

shared_context 'auth needed' do
  let :oauth_client do
    response = double('response')
    double(OAuth2::Client, get: OAuth2::Response.new(response, parse: :json))
  end

  before :each do
    allow(controller).to receive(:auth_needed?).and_return(true)
    allow(controller).to receive(:access_token).and_return(oauth_client)
  end
end

