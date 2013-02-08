Feature: command line interface
  In order to see that my command line interface is working
  As a user
  I want the output compared to the expectation

  Scenario: original example
    Given a file named "example.txt" with:
    """
    100

    ################################
    ~                              #
    #         ####                 #
    ###       ####                ##
    ###       ####              ####
    #######   #######         ######
    #######   ###########     ######
    ################################
    """
    When I run `cave example.txt`
    Then the output should contain:
    """
    1 2 2 4 4 4 4 6 6 6 1 1 1 1 4 3 3 4 4 4 4 5 5 5 5 5 2 2 1 1 0 0
    """
