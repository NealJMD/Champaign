require 'rails_helper'

RSpec.describe PetitionWidget, type: :model do

  let(:content) { {
    petition_text: "Stop rails developers writing tests!",
    require_full_name: true,
    require_email_address: true,
    require_state: false,
    require_country: false,
    require_postal_code: false,
    require_address: false,
    require_city: false,
    require_phone: false,
    checkboxes: [],
    select_box: {},
    comment_textarea: {},
    call_in_form: {},
    letter_sent_form: {},
    form_button_text: "Stop 'em!"
  } }
  let(:params) { { page_display_order: 1, content: content } }
  let(:widget) { PetitionWidget.new(params) }

  subject { widget }
  it { should be_valid }

  describe :content do

    it "should be invalid without a required field" do
      widget.content[:petition_text] = nil
      expect(widget).not_to be_valid
    end

    it "should be invalid with petition_text too short" do
      widget.content[:petition_text] = "meh"
      expect(widget).not_to be_valid
    end

    it "should be valid changin a non-required field" do
      widget.content[:form_button_text] = "Go!"
      expect(widget).to be_valid
    end

    it "should be valid without a non-required field" do
      widget.content.delete(:form_button_text)
      expect(widget).to be_valid
      expect(widget.content[:form_button_text]).to be_nil
    end

    it "should enforce string types" do
      widget.content[:petition_text] = 123
      expect(widget).not_to be_valid
    end
  end
end
