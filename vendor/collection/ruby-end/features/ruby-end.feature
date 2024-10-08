Feature: Insert end
  In order to be quicker in ruby-mode
  As a ruby developer
  I want to automatically have end inserted for blocks
  
  Background:
    Given I am in buffer "*ruby-end*"
    And the buffer is empty
    And ruby-mode is active
    And ruby-end-mode is active
  
  Scenario: Keyword at beginning of line
    When I type "if"
    And I press "SPC"
    And I type "condition"
    Then I should see:
      """
      if condition
        
      end
      """
      
  Scenario: Whitespace before keyword
    When I type "  "
    When I type "if"
    And I press "SPC"
    And I type "condition"
    Then I should see:
      """
        if condition
          
        end
      """

  Scenario: Text before keyword
    When I type "x"
    And I type "if"
    And I press "SPC"
    And I type "condition"
    Then I should see:
      """
      xif condition
      """

  Scenario: Text after keyword
    When I type "condition"
    And I go to the beginning of the line
    And I type "if"
    And I press "SPC"
    Then I should see:
      """
      if condition
      """
    But I should not see:
      """
      if

      endcondition
      """

  Scenario: Other character before keyword
    When I type "!"
    And I type "if"
    And I press "SPC"
    And I type "condition"
    Then I should see:
      """
      !if condition
      """

  Scenario: Nested expansion
    When I type "class"
    And I press "SPC"
    And I type "User"
    And I go to the end of next line
    And I type "def"
    And I press "SPC"
    And I type "email"
    Then I should see:
      """
      class User
        def email
          
        end
      end
      """

  Scenario: Only exact keywords expand
    When I type "xif"
    And I press "SPC"
    And I type "condition"
    Then I should see "xif condition"
    And end should not be insterted
    
  
  # NOTE:
  # I have to hax these two scenarios, since running Emacs in batch
  # mode does not set the text properties.
    
  Scenario: In comment
    Given I insert "# if "
    And I set face to be comment
    And I go back one character
    And I press "SPC"
    And I type "condition"
    Then end should not be insterted

  Scenario: In string
    Given I insert "'if'"
    And I set face to be string
    And I go back one character
    And I press "SPC"
    And I type "condition"
    Then end should not be insterted
