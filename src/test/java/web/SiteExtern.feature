Feature:Exemple d'application web Extern

  Background:
    * def sUrl = "https://www.karatelabs.io/"
    * configure driver = { type: 'msedge', port: 9224, start: true, stop: true, showDriverLog: true, showProcessLog: true, highlight: true, highlightDuration: 2000, addOptions: ['--remote-allow-origins=*'] }

  Scenario: ouverture du site et page de Get Started
  Given driver sUrl
  * print 'debug:', driver.getUrl()
  Then retry(3).waitFor('{^}Open-Source')
  When click('{a}Sign up')
  Then retry(3).waitFor('{^a}Karate Labs')
  When click('{^button}Google')
  And match driver.title == '#present'
  * karate.stop(9999)




