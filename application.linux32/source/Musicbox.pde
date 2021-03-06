/**************** CLASS MUSICBOX ****************/
/* Une Musicbox est un élément auquel on attribue un son dans Pure Data 
 Ils peuvent être un oscillateur ou un sampler */

class Musicbox{
  
  /*-------------------------------------------  VARIABLES */
  
  ArrayList<Satellite> satellites; // Les satellites sont des paramètres (cutoff, release,...) d'une Musicbox. 
                                   // Ils sont représentés par des ronds plut petits.
  float diametreCeinture; // Un satellite se position sur une ceinture autour d'une Musicbox
                 
  String nom; // Nom de la Musicbox [important] à renseigner absolument pour que Pure Data sache de quel élément il s'agit
  float force; // C'est la courbe de progression du volume quand on s'approche du Master au centre
  float volume; // Le volume de l'objet, envoyé à Pure Data
  float distance; // Distance entre l'objet et le Master
  boolean locked; // Si on a positionné le curseur sur l'objet et que l'on a la souris "pressed"

  // Variables pour l'affichage
  PVector vecteur; // On utilise un objet de la classe PVector, pour bénéficier des variables de position et des fonctions comme dist(vecteur1, vecteur2)
  float diametre; // Diametre du rond qui représente l'objet graphiquement
  color couleur; // Couleur de remplissage du rond
  float epaisseurStroke; // Epaisseur de la bordure autour du rond
  color couleurStroke; // Couleur de la bordure autour du rond

  float rayon; // diametre / 2
  
  // Variables pour la physique : quand on donne de l'élan à un élément
  float vitesseX; // élan X
  float vitesseY; // élan Y
  float cibleX; // coordonnée x où l'élément va se rendre avec l'élan qu'on lui a donné
  float cibleY; // coordonnée y où l'élément va se rendre avec l'élan qu'on lui a donné
  float velocite=0.9; // Vitesse de ralentissement
  float vitesseFinale=0; // Vitesse de l'élément sans élan
  float vitesseMinimum=4; // élan minimum pour que ce soit pris en compte
 
 
  /*-------------------------------------------  CONSTRUCTEUR ET VALEURS PAR DEFAUT */
  Musicbox(String _nom){
    satellites = new ArrayList<Satellite>(); 
        
    this.nom = _nom;
    this.volume = 0;
    this.locked = false;
    this.force = 5;
    
    this.vecteur = new PVector();
    this.couleur = color(126, 204, 191);
    this.diametre = 35;
    this.couleurStroke = color(126, 204, 191);
    this.epaisseurStroke = 8;
   
    this.ajustements(); 
  }
  
  /*------------------------------------------- SETTERS */
  
  // Calcul le rayon et le diametre de la ceinture
  void ajustements(){
    this.rayon = this.diametre / 2;
    this.diametreCeinture = this.diametre + this.epaisseurStroke + 50;
  }
  
  // Paramètres graphiques
  void setAffichage(float _diametre, color _couleurRemplissage, color _couleurContour, float _epaisseurContour){
    this.diametre = _diametre;
    this.rayon = this.diametre / 2;
    this.couleur = _couleurRemplissage;
    this.couleurStroke = _couleurContour;
    this.epaisseurStroke = _epaisseurContour;
    this.ajustements();
  }
  
  void setForce(float _force){
    this.force = _force;
  }
  
  /*------------------------------------------- FUNCTIONS */
  
  // Affichage GUI
  void render(){
    strokeWeight(this.epaisseurStroke);
    stroke(this.couleurStroke, 180);
    fill(this.couleur,180);
    ellipse(this.vecteur.x, this.vecteur.y, this.diametre, this.diametre);
    
    this.renderSatellites(); 
  }
  
  void initPosition(float _x, float _y){
    this.vecteur.x = (_x);
    this.vecteur.y = (_y);
  }   
  
  void setPosition(float _x, float _y){
    this.vecteur.x = constrain(_x, 0+this.rayon+this.epaisseurStroke, width-this.rayon-this.epaisseurStroke);
    this.vecteur.y = constrain(_y, 0+this.rayon+this.epaisseurStroke, height-this.rayon-this.epaisseurStroke);
  }   
  
  // Calcule le volume perçu et envoie la valeur au patch Pure Data
  void setVolume(PVector _vecteurMaster){
    this.distance = this.vecteur.dist(this.vecteur, _vecteurMaster);
    this.volume = (this.distance / (width / 2.5)) * (-1) + 1;
    this.volume = this.volume / this.force;
    
    if(this.volume < 0){
      this.volume = 0;
    }
  
    this.setPdParm(this.nom, "Volume", this.volume);
  }
  
  void collisionEcran(){
    // X
    if((this.vecteur.x + this.rayon + this.epaisseurStroke - width==0) || (this.vecteur.x - this.rayon - this.epaisseurStroke==0)){
      this.vitesseX*=-1;
    }
    
    // Y
    if((this.vecteur.y + this.rayon + this.epaisseurStroke - height==0) || (this.vecteur.y - this.rayon - this.epaisseurStroke==0)){
      this.vitesseY*=-1;
    }
  }
  
  // Envoie les valeurs à Pure Data.
  // Le paramètre se compose du nom de l'objet, du nom du paramètre, de sa valeur
  // Ensuite, on forme un String avec le nom de l'objet et du paramètre
  // Ex : oscillateur, Cutoff, 36
  // -> devient oscillateurCutoff
  // Pour ensuite être transmis à une variable du même nom dans Pure Data
  void setPdParm(String _nomObjet, String _nomParametre, float _valeur){
    String nomEtParametre = _nomObjet + _nomParametre;
    pd.sendFloat(nomEtParametre, _valeur);
  }
  
  // Calcul l'élan que l'on donne avec le mouvement de souris
  void calculeVitesse(float _x, float _y){
    this.vitesseX = _x - this.vecteur.x;
    this.vitesseY = _y - this.vecteur.y;
    if(abs(this.vitesseX) < vitesseMinimum){
      this.vitesseX = this.vitesseFinale;
    }
    if(abs(this.vitesseY) < vitesseMinimum){
      this.vitesseY = this.vitesseFinale;
    }
  }
  
  // Calcule jusqu'où le point devrait se rendre grâce à l'élan
  void calculeCible(float _x, float _y){
    if(this.locked){
      this.cibleX = _x + this.vitesseX;
      this.cibleY = _y + this.vitesseY;
    }
  }
  
  // L'élément se déplace grâce à l'élan mais perd en vitesse
  void ralentit(){
    if(!this.locked){
      if(this.vitesseX != this.vitesseFinale){
        this.vitesseX = this.vitesseX * this.velocite;
        this.setPosition(this.vecteur.x + this.vitesseX, this.vecteur.y);
      }
      if(this.vitesseY != this.vitesseFinale){
        this.vitesseY = this.vitesseY * this.velocite;
        this.setPosition(this.vecteur.x, this.vecteur.y + this.vitesseY);
      }
      this.collisionEcran();
    }
  }
  
  // Reset de l'élan à 0
  void resetvitesse(){
    this.vitesseX = this.vitesseFinale;
    this.vitesseY = this.vitesseFinale;
  }
  
  // Affichage GUI des satellites
  void renderSatellites(){
    // On affiche les satellites si on est au dessus des ceintures OU si un des satellites est locked
    // (ce qui veut dire que l'utilisateur est en train de Dragger la souris pour déplacer un satellite)
    if(this.overCeinture() || this.satelliteLocked()){
      
      Satellite sat;  
      
      for(int i=0; i<this.satellites.size(); i++){
        sat = this.satellites.get(i);
        sat.render(this.vecteur, this.diametreCeinture * (i+1), i); // Chaque nouveau paramètre est dessiné sur une ceinture plus grande
        if(sat.valeurMs==0){
          this.setPdParm(this.nom, sat.nom, sat.valeur);
        }else{
          this.setPdParm(this.nom, sat.nom, sat.valeurMs);
        }
      }
    }
  }
 
  /*------------------------------------------- BOOLEENS */
   
  // Retourne true si la souris se trouve sur l'objet
  boolean over() {
    if(dist(mouseX, mouseY, this.vecteur.x, this.vecteur.y) - this.rayon <= 0){
      return true;
    }else{
      return false;
    }
  }
  
  // Retourne true si la souris se trouve sur la zone Ceinture
  boolean overCeinture() {
    if(dist(mouseX, mouseY, this.vecteur.x, this.vecteur.y) - this.diametreCeinture - 10 <= 0){
      return true;
    }else{
      return false;
    }
  }
  
  // On teste si au moins 1 des satellites est utilisé
  boolean satelliteLocked(){
    int ok = 0;
    
    for(int i=0; i<this.satellites.size(); i++){
      if(this.satellites.get(i).locked){
        ok = 1;
      }
    }
    
    if(ok == 1){
      return true;
    }else{
      return false;
    }
  }
}
/**************** END CLASS MUSICBOX ****************/

