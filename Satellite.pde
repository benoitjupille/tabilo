/**************** CLASS SATELLITE ****************/
/* Les satellites sont des paramètres (cutoff, release,...) d'une Musicbox. 
Ils sont représentés par des ronds plut petits. */

class Satellite{
  
  /*-------------------------------------------  VARIABLES */
  float valeur; // Valeur du paramètre
  String nom; // Nom du paramètre [important] à renseigner absolument pour que Pure Data sache de quel élément il s'agit
  boolean locked; // Si on a positionné le curseur sur l'objet et que l'on a la souris "pressed" => donc que le paramètre est en train d'être modifié
  PVector vecteur; // On utilise un objet de la classe PVector, pour bénéficier des variables de position et des fonctions comme dist(vecteur1, vecteur2)
  float diametre; // Diametre du rond qui représente l'objet graphiquement
  color couleur; // Couleur du rond 
  float rayon; 
  float angleDepart; // Départ de l'arc de cercle
  float angleFin; // Fin de l'arc de cercle. On utilise de 0 à 127, puisque les valeurs envoyées à Pure Data vont de 0 à 127
    
    
  /*-------------------------------------------  CONSTRUCTEUR ET VALEURS PAR DEFAUT */
  Satellite(String _nom){
    this.nom = _nom;
    this.locked = false;
    this.valeur = 80;
    
    this.vecteur = new PVector();
    this.couleur = color(168, 26, 26);
    this.diametre = 40;
    this.rayon = this.diametre / 2;
    
    this.angleDepart = 0;
    this.angleFin = 127;
  }
  
  /*------------------------------------------- SETTERS */
  
  void setCouleur(color _color){
    this.couleur = _color;
  }
  
  void setValeur(float _valeur){
    this.valeur = _valeur;
  }
  
  // Renseigne la position du satellite sur sa ceinture, en fonction de sa valeur, de la position de la box et du diamètre de la ceinture
  void setPosition(PVector _vecteurMusicbox, float _diametre){
    this.vecteur.x = cos(radians(this.valeur)) * (_diametre / 2);
    this.vecteur.y = sin(radians(this.valeur)) * (_diametre / 2);
    
    // Maintenant on ajoute la position de la box
    this.vecteur.x = this.vecteur.x + _vecteurMusicbox.x;
    this.vecteur.y = this.vecteur.y + _vecteurMusicbox.y;
  }
  
  // On renseigne la valeur du satellite par les mouvements de la souris
  // C'est ensuite la fonction setPosition(...), appelée dans render(...) qui se chargera de calculer les coordonnées
  void setValeurParPosition(){
    if(mouseY > pmouseY){
      if(this.valeur < angleFin){
        this.valeur++;
      }
    }
    if(mouseX < pmouseX){
      if(this.valeur < angleFin){
        this.valeur++;
      }
    }
    if(mouseY < pmouseY){
      if(this.valeur > angleDepart){
        this.valeur--;
      }
    }
    if(mouseX > pmouseX){
      if(this.valeur > angleDepart){
        this.valeur--;
      }
    }
    print(this.valeur);
  }
  
  /*------------------------------------------- FUNCTIONS */ 
  
  // Affichage GUI
  void render(PVector _vecteurMusicbox, float _diametreCeinture, float _id){   
    // Dessine la ceinture
    fill(250, 250, 250, 0);
    strokeWeight(1);
    stroke(0, 50);
    arc(_vecteurMusicbox.x, _vecteurMusicbox.y, _diametreCeinture, _diametreCeinture, radians(angleDepart), radians(angleFin), OPEN);
    
    // Positionne le paramètre sur la ceinture en fonction de sa valeur
    this.setPosition(_vecteurMusicbox, _diametreCeinture);
    
    // Dessine le rond qui représente le paramètre
    noStroke();
    fill(this.couleur,180);
    ellipse(this.vecteur.x, this.vecteur.y, this.diametre, this.diametre);
  }
  
  /*------------------------------------------- BOOLEENS */
  
  // Retourne true si la souris se trouve sur le satellite
  boolean overSatellite() {
    if(dist(mouseX, mouseY, this.vecteur.x, this.vecteur.y) - this.rayon <= 0){
      return true;
    }else{
      return false;
    }
  }
}
