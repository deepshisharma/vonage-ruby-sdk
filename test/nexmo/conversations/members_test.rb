require_relative '../test'

class Nexmo::Conversations::MembersTest < Nexmo::Test
  def members
    Nexmo::Conversations::Members.new(config)
  end

  def members_uri
    "https://api.nexmo.com/v0.1/conversations/#{conversation_id}/members"
  end

  def member_uri
    "https://api.nexmo.com/v0.1/conversations/#{conversation_id}/members/#{member_id}"
  end

  def create_params
    {
      action: 'invite',
      user_id: user_id,
      channel: {
        type: 'phone',
      }
    }
  end

  def update_params
    {
      state: 'join',
      channel: {
        type: 'phone',
      }
    }
  end

  def test_create_method
    stub_request(:post, members_uri).with(request(body: create_params)).to_return(response)

    assert_kind_of Nexmo::Response, members.create(conversation_id, create_params)
  end

  def test_list_method
    stub_request(:get, members_uri).with(request).to_return(response)

    assert_kind_of Nexmo::Response, members.list(conversation_id)
  end

  def test_get_method
    stub_request(:get, member_uri).with(request).to_return(response)

    assert_kind_of Nexmo::Response, members.get(conversation_id, member_id)
  end

  def test_update_method
    stub_request(:put, member_uri).with(request(body: update_params)).to_return(response)

    assert_kind_of Nexmo::Response, members.update(conversation_id, member_id, update_params)
  end

  def test_delete_method
    stub_request(:delete, member_uri).with(request).to_return(response)

    assert_kind_of Nexmo::Response, members.delete(conversation_id, member_id)
  end
end
