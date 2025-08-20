require "application_system_test_case"

class ProceduresTest < ApplicationSystemTestCase
  setup do
    @procedure = procedures(:one)
  end

  test "visiting the index" do
    visit procedures_url
    assert_selector "h1", text: "Procedures"
  end

  test "should create procedure" do
    visit procedures_url
    click_on "New procedure"

    fill_in "Description", with: @procedure.description
    fill_in "Name", with: @procedure.name
    fill_in "Price", with: @procedure.price
    click_on "Create Procedure"

    assert_text "Procedure was successfully created"
    click_on "Back"
  end

  test "should update Procedure" do
    visit procedure_url(@procedure)
    click_on "Edit this procedure", match: :first

    fill_in "Description", with: @procedure.description
    fill_in "Name", with: @procedure.name
    fill_in "Price", with: @procedure.price
    click_on "Update Procedure"

    assert_text "Procedure was successfully updated"
    click_on "Back"
  end

  test "should destroy Procedure" do
    visit procedure_url(@procedure)
    accept_confirm { click_on "Destroy this procedure", match: :first }

    assert_text "Procedure was successfully destroyed"
  end
end
