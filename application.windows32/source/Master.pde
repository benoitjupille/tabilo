/**************** CLASS MASTER ****************/
/* Element au centre qui ne bouge pas. Plus on approche une Musicbox de lui, 
et plus le volume de cette Musicbox sera élevé */

class Master{
  
  /*-------------------------------------------  VARIABLES */
  PVector vecteur; // On utilise un objet de la classe PVector, pour bénéficier des variables de position et des fonctions comme dist(vecteur1, vecteur2)
  float diametre; // Diametre du rond qui représente l'objet graphiquement
  color couleur; // Couleur de remplissage du rond 
  float epaisseurStroke; // Epaisseur de la bordure autour du rond
  color couleurStroke; // Couleur de la bordure autour du rond
 
  float wobbling; // rapidité de l'effet vibration
  int wobbleWay; // 0 = gonfle; 1 = dégonfle
  float diametreMax; // Diametre maximum lors du wobbling
  float diametreMin; // Diametre mini lors du wobbling
  
  
  /*-------------------------------------------  CONSTRUCTEUR ET VALEURS PAR DEFAUT */
  Master(){
    this.vecteur = new PVector();
    this.couleur = color(244, 242, 204);
    this.epaisseurStroke = 8;
    this.couleurStroke = color(120, 0, 0);
    this.diametreMax = 40;
    this.diametreMin = 38;
    this.diametre = this.diametreMax;
    this.wobbling = 1;
    this.wobbleWay = 0;
  }
  
  /*------------------------------------------- SETTERS */
  
  void setPosition(float _x, float _y){
    this.vecteur.set(_x, _y, 0);
  }   
  
  /*------------------------------------------- FUNCTIONS */
  
  // dessine le cercle
  void render(){
    fill(this.couleur);
    stroke(this.couleurStroke, 100);
    strokeWeight(this.epaisseurStroke);
    ellipse(this.vecteur.x, this.vecteur.y, this.diametre, this.diametre);
    this.wobble();
  }
  
  // Fait vibrer le cercle sur lui même
  void wobble(){
    if(this.wobbleWay == 0){
      if(this.diametre <= this.diametreMin){
        this.wobbleWay = 1;
      }else{
        this.diametre = this.diametre - this.wobbling;
      }
    }else{
      if(this.diametre >= this.diametreMax){
        this.wobbleWay = 0;
      }else{
        this.diametre = this.diametre + this.wobbling;
      }
    }
  }
}
/**************** END CLASS MASTER ****************/
