Feature:Exemple d'application web Extern

  Background:
    * def sUrl = "https://practice-automation.com/"
    * configure driver = { type: 'msedge', port: 9224, start: true, stop: true, showDriverLog: true, showProcessLog: true, highlight: true, highlightDuration: 2000, addOptions: ['--remote-allow-origins=*'] }
    * def oForm = callonce read 'classpath:Dictionnaire/Form.json'
     * def getValue = function (insName){return script("document.getElementById('" + insName + "').value")}
     * def isChecked = function (insName){return script("document.getElementById('" + insName + "').checked")}
     * def getSelected = function (insName){ return script("var oItem = document.getElementById('" + insName + "');  oItem.options[oItem.selectedIndex].text")}
#    * def isChecked2 =
#    """
#      function (insName){
#        let sJs = `
#            var oFound = document.querySelectorAll('label');
#            var tabAll = [...oFound];
#            var tabLabel = tabAll.filter(el => el.textContent.includes('${insName}'));
#            var sId = tabLabel[0].attr('for');
#            document.getElementById(sId).checked"
#            `;
#        return script(sJs);
#    }
#    """

  Scenario: ouverture du site et remplir le form
    Given driver sUrl
    * print 'debug:', driver.getUrl()
    Then retry(3).waitFor('{^}Welcome to your software')
    When click('{a}Form Fields')
    Then retry(3).waitFor('{^}Name (required)')
    * input('#name','Elham')
    * waitFor('#name')
    * click('{^}Wine')
    * click('{label}Blue')
    * select('select[name=siblings]','{^}Yes')
    Then delay(2000)
    * match getValue('name') == 'Elham'
    * match isChecked('drink4') == true
    * match isChecked('color2') == true
    * match isChecked2('Blue') == true
    * match getSelected('siblings') contains 'Yes'
    * click('{^button}Submit')
    * delay(2000)
    * dialog(true)
    * delay(2000)

  Scenario: ouverture du site et
    Given driver sUrl
    * print 'debug:', driver.getUrl()
    Then retry(3).waitFor(oForm.welcome)
    When click(oForm.form)
    Then retry(3).waitFor(oForm.name)
    * input(oForm.username, 'Elham')
    * click(oForm.checkbox)
    * click(oForm.radiobutton)
    * select(oForm.sibling,'Yes')
    Then delay(5000)
    * click(oForm.button)
    * delay(2000)
    * dialog(true)
    * delay(2000)

  Scenario: ouverture du site
    Given driver sUrl
    * print 'debug:', driver.getUrl()
    Then retry(3).waitFor(oForm.welcome)
    When click(oForm.form)
    Then retry(3).waitFor(oForm.name)
    * input(oForm.username,'Elham')
    * click(oForm.Wine)
    * click(oForm.Blue)
    * select(oForm.sibling,'Yes')
    Then delay(2000)
    * click(oForm.submit)
    * delay(2000)
    * dialog(true)
    * delay(2000)



  Scenario Outline: diffrent users with diffrent sibling
    Given driver sUrl
    * print 'debug:', driver.getUrl()
    Then retry(3).waitFor(oForm.welcome)
    When click(oForm.form)
    Then retry(3).waitFor(oForm.name)
    * input(oForm.username,'<Name>')
    * click(oForm.Wine)
    * click(oForm.Blue)
    * select(oForm.sibling,'<Sibling>')
    * match getValue('name') == '<Name>'
    * match getValue('drink4') contains '<Drink>'
    * match getValue('color2') contains '<Color>'
#    * match getSelected('siblings') contains '<sibling>'
    Then delay(2000)
    * click(oForm.submit)
    * delay(2000)
    * dialog(true)
    * print 'debug value:', getValue('name')
    * delay(2000)


    Examples:
      | Name  | Sibling  | Drink  | Color
      | Elham | {^}Yes   | Wine  | Blue
      | Test1 | {^}No    | Coffee | Yellow
      | Test2 | {^}Maybe | Water  | Green


  Scenario: Test site full html
    * def isChecked = function(insTextLabel) { return script('#' + attribute(insTextLabel,'for'), '_.checked') }
    Given driver "https://practice-automation.com/"
    * print 'debug:', driver.getUrl()
    Then retry(3).waitFor('{^h1/strong}Welcome to your software automation practice website')

    When click('{^a}Form Fields')
    Then retry(3).waitFor('{^h1}Form Fields')

    When input('#name', 'Thierry')
    Then match value('#name') contains 'Thierry'

    When click('{^}Water')
    Then match script('#drink1', '_.checked') == true
    And match script('#' + attribute('{^}Water','for'), '_.checked') == true
    And match isChecked('{^}Water') == true
    And match isChecked('{^}Wine') == false

    When click('{^}Yellow')
    Then match script('#color3', '_.checked') == true

    When select('select[name=siblings]', '{^}Maybe')
    Then match script('#siblings', '_.value') contains 'maybe'

    When input('textarea[name=message]', 'karate is wonderfull !')
    Then match value('textarea[name=message]') contains 'karate is wonderfull'




   Scenario Outline: test clear
    * def isChecked = function(insTextLabel) { return script('#' + attribute(insTextLabel,'for'), '_.checked') }
    * def setValue = function(insLocateur,insValue){const oDriver = karate.get('driver');oDriver.input(insLocateur, insValue);return oDriver.value(insLocateur)}
    * def setSelect = function(insLocateur,insValue){const oDriver = karate.get('driver');oDriver.select(insLocateur, '{^}' + insValue);return oDriver.script(insLocateur, '_.value')}
    * def setChoice =
      """
        function(insText){
          const oDriver = karate.get('driver');
          oDriver.click('{^}'+insText);
          return oDriver.script('#' + attribute('{^}'+insText,'for'), '_.checked')
        }
      """
    Given driver "https://practice-automation.com/"
    * print 'debug:', driver.getUrl()
    Then retry(3).waitFor('{^h1/strong}Welcome to your software automation practice website')
    When click('{^a}Form Fields')
    Then retry(3).waitFor('{^h1}Form Fields')
    And match setValue('#name', '<Name>') contains '<Name>'
    And match setChoice('<Drink1>') == true
    And match setChoice('<Drink2>') == true
    And match setChoice('<Color>') == true
    And match setSelect('#siblings','<Sibling>') contains karate.lowerCase('<Sibling>')
    And match setValue('textarea[name=message]', 'karate is wonderfull') contains 'karate is wonderfull'

    Examples:
      | Name  | Sibling | Drink1 | Drink2 | Color |
      | Elham | Yes     | Wine   | Water  | Blue  |
      | Test1 | No      | Coffee | Wine   | Yellow|
      | Test2 | Maybe   | Water  | Coffee | Green |
