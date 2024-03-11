Feature:Exemple d'application web interne

  Background:
    * def sUrl = "https://jira.zas.admin.ch"
    * configure ssl = { keyStore: 'classpath:BITProxyCA.jks'}
    * configure proxy = { uri: 'http://proxy-bvcol.admin.ch:8080',  nonProxyHosts: ['localhost','127.0.0.1','*.admin.ch']}
    * configure driver = { type: 'msedge', port: 9226, start: true, stop: true, showDriverLog: true, showProcessLog: true, highlight: true, highlightDuration: 2000, addOptions: ['--remote-allow-origins=*'] }
    * def oLogin = callonce read 'classpath:Dictionnaire/Login.json'


  Scenario: ouverture du site et mettre username password et connexion
  Given driver sUrl
  * print 'debug:', driver.getUrl()
  Then retry(3).waitFor('{h1}System Dashboard')
  When input('#login-form-username',"EAB")
  And input('#login-form-password',"1367Elno63@")
  And click('#login')
  * print oLogin.user1
  * karate.stop(9999)
