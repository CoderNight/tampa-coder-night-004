Feature: Test out iterations of the cave
  In order to make sure the program is working properly
  As a programmer
  I want to see each iteration of the steps

  Background:
    Given a cave that looks like
    """
    ################################
    ~                              #
    #         ####                 #
    ###       ####                ##
    ###       ####              ####
    #######   #######         ######
    #######   ###########     ######
    ################################
    """
  Scenario: initial position
    When I iterate 1 times
    Then the cave should look like
    """
    ################################
    ~                              #
    #         ####                 #
    ###       ####                ##
    ###       ####              ####
    #######   #######         ######
    #######   ###########     ######
    ################################
    """
  Scenario: initial position
    When I iterate 2 times
    Then the cave should look like
    """
    ################################
    ~~                             #
    #         ####                 #
    ###       ####                ##
    ###       ####              ####
    #######   #######         ######
    #######   ###########     ######
    ################################
    """
  Scenario: initial position
    When I iterate 3 times
    Then the cave should look like
    """
    ################################
    ~~                             #
    #~        ####                 #
    ###       ####                ##
    ###       ####              ####
    #######   #######         ######
    #######   ###########     ######
    ################################
    """
  Scenario: initial position
    When I iterate 4 times
    Then the cave should look like
    """
    ################################
    ~~                             #
    #~~       ####                 #
    ###       ####                ##
    ###       ####              ####
    #######   #######         ######
    #######   ###########     ######
    ################################
    """

  Scenario: initial position
    When I iterate 5 times
    Then the cave should look like
    """
    ################################
    ~~                             #
    #~~~      ####                 #
    ###       ####                ##
    ###       ####              ####
    #######   #######         ######
    #######   ###########     ######
    ################################
    """
  Scenario: initial position
    When I iterate 6 times
    Then the cave should look like
    """
    ################################
    ~~                             #
    #~~~      ####                 #
    ###~      ####                ##
    ###       ####              ####
    #######   #######         ######
    #######   ###########     ######
    ################################
    """
  Scenario: initial position
    When I iterate 7 times
    Then the cave should look like
    """
    ################################
    ~~                             #
    #~~~      ####                 #
    ###~      ####                ##
    ###~      ####              ####
    #######   #######         ######
    #######   ###########     ######
    ################################
    """
  Scenario: initial position
    When I iterate 8 times
    Then the cave should look like
    """
    ################################
    ~~                             #
    #~~~      ####                 #
    ###~      ####                ##
    ###~~     ####              ####
    #######   #######         ######
    #######   ###########     ######
    ################################
    """
  Scenario: initial position
    When I iterate 11 times
    Then the cave should look like
    """
    ################################
    ~~                             #
    #~~~      ####                 #
    ###~      ####                ##
    ###~~~~~  ####              ####
    #######   #######         ######
    #######   ###########     ######
    ################################
    """
  Scenario: initial position
    When I iterate 14 times
    Then the cave should look like
    """
    ################################
    ~~                             #
    #~~~      ####                 #
    ###~      ####                ##
    ###~~~~~  ####              ####
    #######~  #######         ######
    #######~~ ###########     ######
    ################################
    """
  Scenario: initial position
    When I iterate 15 times
    Then the cave should look like
    """
    ################################
    ~~                             #
    #~~~      ####                 #
    ###~      ####                ##
    ###~~~~~  ####              ####
    #######~  #######         ######
    #######~~~###########     ######
    ################################
    """
  Scenario: initial position
    When I iterate 16 times
    Then the cave should look like
    """
    ################################
    ~~                             #
    #~~~      ####                 #
    ###~      ####                ##
    ###~~~~~  ####              ####
    #######~~ #######         ######
    #######~~~###########     ######
    ################################
    """
  Scenario: initial position
    When I iterate 17 times
    Then the cave should look like
    """
    ################################
    ~~                             #
    #~~~      ####                 #
    ###~      ####                ##
    ###~~~~~  ####              ####
    #######~~~#######         ######
    #######~~~###########     ######
    ################################
    """
  Scenario: initial position
    When I iterate 31 times
    Then the cave should look like
    """
    ################################
    ~~                             #
    #~~~~~~~~~####                 #
    ###~~~~~~~####                ##
    ###~~~~~~~####              ####
    #######~~~#######         ######
    #######~~~###########     ######
    ################################
    """
  Scenario: initial position
    When I iterate 44 times
    Then the cave should look like
    """
    ################################
    ~~~~~~~~~~~~~~~                #
    #~~~~~~~~~####                 #
    ###~~~~~~~####                ##
    ###~~~~~~~####              ####
    #######~~~#######         ######
    #######~~~###########     ######
    ################################
    """
  Scenario: initial position
    When I iterate 100 times
    Then the cave should look like
    """
    ################################
    ~~~~~~~~~~~~~~~                #
    #~~~~~~~~~####~~~~~~~~~~~~     #
    ###~~~~~~~####~~~~~~~~~~~~~~~~##
    ###~~~~~~~####~~~~~~~~~~~~~~####
    #######~~~#######~~~~~~~~~######
    #######~~~###########~~~~~######
    ################################
    """
    