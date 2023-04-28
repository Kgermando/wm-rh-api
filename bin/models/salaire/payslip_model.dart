class PaySlip {
  late int? id;
  late String matricule;
  late String siteLocation;
  late String nom;
  late String postNom;
  late String prenom;
  late String titleEmploi;
  late String statutProfesionnel;  // Cadre
  late String gradeEmploi;
  late String salaireBaseUSD;
  late String salaireBaseCDF;
  late String indemniteLogement;
  late String indemniteTransport;
  late String allocationResponsabilite;
  late String bonus;
  late String fraisBancaire;
  late String etatCivile;
  late String epouseMontant;
  late String nbrEnfant;
  late String montantParEnfant;
  late String h130Heure;
  late String h130Montant;
  late String h160Heure;
  late String h160Montant;
  late String h200Heure;   // Dimanche et jours ferié H2.00
  late String h200Montant; // Dimanche et jours ferié H2.00
  late String h025Heure;   // Ronde de nuit H0.25
  late String h025Montant; // Ronde de nuit H0.25
  late String congeMaladieJrs; // 2/3 paie
  late String congeMaladieMontantSB; // Montant à deduire du SB
  late String congeMaladieMontantTransport; // Montant à deduire à l'indemnité de Transport
  late String absenceSansPaiementJrs;
  late String absenceSansPaiementMontantSB; // Montant à deduire du SB
  late String absenceSansPaiementTransport; // Montant à deduire à l'indemnité de Transport
  late String suspensionSansPaiementJrs;
  late String suspensionSansPaiementMontantSB; // Montant à deduire du SB
  late String suspensionSansPaiementTransport; // Montant à deduire à l'indemnité de Transport
  late String backpayJrs; // Backpay (Days to be refunded)
  late String backpayMontantAjouterSB; // Backpay (Days to be refunded)
  late String backpayAjouterIndemniteTransport; // Backpay (Days to be refunded)
  late String baseImposableCNSSINPPONEM; 
  late String baseImposableIPR;
  late String baseImposableIPRCDF;

  // RETENUES SUR LE SALAIRE
  late String cNSSQPO;  //     CNSS - QPO 5%
  late String totalIPRCDF;
  late String totalIPRUSD;
  late String montantDeduireIPR; // Montant à déduire sur IPR (Nombre des Dependants) 0.20%
  late String iprAjoute;
  late String avanceSalaire;
  late String diversAvance;
  late String cotisationSyndicale;

  // IMPÔT SUR LA SOCIÉTÉ
  late String cNSSQPP;  // CNSS - QPP 13%
  late String inppSociete;
  late String onemSociete;
  late String totalRevenues;
  late String totalDeductions;
  late String netApayer; 


  

  late String signature;
  late DateTime created;
  late DateTime updateCreated;
}