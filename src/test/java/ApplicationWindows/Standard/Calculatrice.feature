Feature: windows calculator

  @parallel=false
  Scenario:
    * robot { window: 'Calculatrice', fork: 'calc', highlight: true, highlightDuration: 500 }
    * click('Effacer')
    * click('Six')
    * click('Quatre')
    * click('Racine carrée')
    * click('Multiplier par')
    * click('Huit')
    * click('Est égal à')
    * match locate('#CalculatorResults').name == "L'affichage est 64"
    * screenshot()
    * click('Fermer Calculatrice')
