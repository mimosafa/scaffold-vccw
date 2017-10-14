Feature: Test that WP-CLI `vccw/scaffold-vccw` loads.

  Scenario: Run `wp scaffold vccw` without option
    Given an empty directory

    When I run `wp help scaffold vccw`
    Then the return code should be 0
    And STDOUT should contain:
      """
      Generate a new VCCW environment.
      """

    When I run `wp scaffold vccw vccw.test`
    Then the return code should be 0
    And the vccw.test directory should exist
    And STDOUT should contain:
      """
      Success: Generated.
      """
    And the vccw.test/provision/default.yml file should exist
    And the vccw.test/site.yml file should exist
    And the vccw.test/site.yml file should contain:
      """
      hostname: vccw.test
      ip: 192.168.33.10
      """
    And the vccw.test/site.yml file should contain:
      """
      lang: en_US
      """

  Scenario: Run `wp scaffold vccw` with option
    Given an empty directory

    When I run `wp scaffold vccw . --host=wp.dev --ip=192.123.123.123 --lang=ja`
    Then the return code should be 0
    And STDOUT should contain:
      """
      Success: Generated.
      """
    And the provision/default.yml file should exist
    And the site.yml file should exist
    And the site.yml file should contain:
      """
      hostname: wp.dev
      ip: 192.123.123.123
      """
    And the site.yml file should contain:
      """
      lang: ja
      """

  Scenario: Run `wp scaffold vccw` with option
    Given an empty directory

    When I run `wp scaffold vccw . --lang=tr_TR`
    Then the return code should be 0
    And STDOUT should contain:
      """
      Success: Generated.
      """
    And the site.yml file should contain:
      """
      lang: tr_TR
      """

    When I try `wp scaffold vccw .`
    Then STDERR should contain:
      """
      Error: `site.yml` already exists.
      """

    When I run `wp scaffold vccw . --update`
    Then the return code should be 0
    And STDOUT should contain:
      """
      Success: Updated.
      """
    And the site.yml file should contain:
      """
      lang: tr_TR
      """
