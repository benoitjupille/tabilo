/* Les modulo sont les éléments rattachés à une Musicbox. Ils permettent de régler des paramètres (note, decay, attack...) */
class Modulo extends Musicbox{
  
  /*-------------------------------------------  VARIABLES */
  
  int linkedTo; // Le linkedTo permet de dire que cet objet est lié à un autre objet 
                // Le linkedTo est un int qui prend l'id d'un objet de la collection <Array>boxes 
              
  int valeurX;
  int valeurY;
  
  float valeurMax = 127.0;
  float coefficientX;
  float coefficientY;
  
  boolean grilleY;
  boolean grilleX;
    
  int[] grilleValeurX = new int[128];
  int[] grilleValeurY = new int[128];
  
  /*-------------------------------------------  CONSTRUCTEUR ET VALEURS PAR DEFAUT */
  
  Modulo(String _nom){
    super(_nom);
    this.coefficientX = valeurMax / width;
    this.coefficientY = valeurMax / height;  
    
    this.grilleX = false; 
    this.grilleY = false;
  }
  
  /*------------------------------------------- SETTERS */
  
  void setLinkedTo(int _id){
    this.linkedTo = _id;
  }
  
  void setGrilleNotesX(int _nombreDeNotes){
    this.grilleX = true;
    int indice = 0;
    int note = 24;
    
    for(int j=0; j<4; j++){
      for(int i=0; i<round(this.valeurMax/_nombreDeNotes); i++){
        this.grilleValeurX[indice] = note;
        indice++;
      }
      for(int i=0; i<round(this.valeurMax/_nombreDeNotes); i++){
        this.grilleValeurX[indice] = note + 1;
        indice++;
      }
      for(int i=0; i<round(this.valeurMax/_nombreDeNotes); i++){
        this.grilleValeurX[indice] = note + 3;
        indice++;
      }
      for(int i=0; i<round(this.valeurMax/_nombreDeNotes); i++){
        this.grilleValeurX[indice] = note + 5;
        indice++;    
      }
      for(int i=0; i<round(this.valeurMax/_nombreDeNotes); i++){
        this.grilleValeurX[indice] = note + 6;
        indice++;
      }
      for(int i=0; i<round(this.valeurMax/_nombreDeNotes); i++){
        this.grilleValeurX[indice] = note + 7;
        indice++;
      }
      for(int i=0; i<round(this.valeurMax/_nombreDeNotes); i++){
        this.grilleValeurX[indice] = note + 10;
        indice++;
      }
      for(int i=0; i<round(this.valeurMax/_nombreDeNotes); i++){
        this.grilleValeurX[indice] = note + 11;
        indice++;
      }
      note = note + 12;
    }
  }
  
  // Place automatiquement le modulo en fonction des coordonnées de la box à laquelle il est rattaché. 
  // _box : box rattachée
  // place : si c'est le premier ou deuxième modulo de la box en question(ou troisième etc)
  void autoPosition(Musicbox _box, int _place){
    if(_place==1){
      this.setPosition(_box.vecteur.x - _box.diametre, _box.vecteur.y - _box.diametre);
    }else{
      if(_place==2){
        this.setPosition(_box.vecteur.x + _box.diametre, _box.vecteur.y - _box.diametre);
      }else{
        if(_place==3){
          this.setPosition(_box.vecteur.x + _box.diametre, _box.vecteur.y + _box.diametre);
        }else{
          if(_place==4){
            this.setPosition(_box.vecteur.x - _box.diametre, _box.vecteur.y + _box.diametre);
          }
        }
      }
    }
  }
  
  /*------------------------------------------- FUNCTIONS */
  
  void render(Musicbox _musicbox){
    super.render();
    strokeWeight(1);
    stroke(0, 50);
    line(this.vecteur.x, this.vecteur.y, _musicbox.vecteur.x, _musicbox.vecteur.y);
    
    this.valeurX = round(this.vecteur.x * coefficientX);
    this.valeurY = round(this.vecteur.y * coefficientY);
    
    if(this.grilleX){
      this.valeurX = this.grilleValeurX[this.valeurX];
    }
    
    setPdParmX(_musicbox.nom, this.nom, valeurX);
    setPdParmY(_musicbox.nom, this.nom, valeurY);
  }
  
  void setPdParmX(String _nomObjet, String _nomParametre, int _valeur){
    String nomEtParametre = _nomObjet + _nomParametre + "X";
    pd.sendFloat(nomEtParametre, _valeur);
  }
  
  void setPdParmY(String _nomObjet, String _nomParametre, int _valeur){
    String nomEtParametre = _nomObjet + _nomParametre + "Y";
    pd.sendFloat(nomEtParametre, _valeur);
  }
}
