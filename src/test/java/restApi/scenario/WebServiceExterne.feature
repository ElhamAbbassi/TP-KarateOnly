Feature: Exemple de webservice Rest externe

  Background:
    * url 'https://jsonplaceholder.typicode.com'
    * configure ssl = { keyStore: 'classpath:BITProxyCA.jks'}
    * configure proxy = { uri: 'http://proxy-bvcol.admin.ch:8080',  nonProxyHosts: ['localhost','127.0.0.1','*.admin.ch']}

  Scenario: get all users and then get the first user by id
    # Load all users
  Given path 'users'
  When method get
  Then status 200
  And match $[*].id == '#notnull'
  * def listUser = response
  * print response
  And assert listUser.length > 1

  Scenario:
    Given path 'users'
    When method get
    Then status 200
    And match $.email == '#present'

