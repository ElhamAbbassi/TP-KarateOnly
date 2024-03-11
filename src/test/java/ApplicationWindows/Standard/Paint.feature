Feature: Paint

  Scenario: open the paint
    * robot { window: 'Sans titre - Paint' , fork: 'mspaint', highlight: true , highlightDuration: 500 }
    * locate('//MenuBar').click('Fichier')
     # verifier menu
    * waitFor('Ouvrir').click()



  Scenario:
    * robot { window: 'Sans titre - Paint' , fork: 'mspaint', highlight: true , highlightDuration: 500 }
    * locate('Couleurs').click('Rouge')
    * click('Texte')
    * locate('Pane').click()

















