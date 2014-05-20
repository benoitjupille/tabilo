/* Les General permettent de définir les propriétés générales d'un morceau : tempo, etc... */
class General extends Musicbox{
  
  /*-------------------------------------------  VARIABLES */
              
  int valeurX;
  int valeurY;
  
  float valeurMaxX = 280.0;
  float valeurMinX = 60.0;
  float valeurMaxY = 280.0;
  float valeurMinY = 60.0;
  float coefficientX;
  float coefficientY;
  
  /*-------------------------------------------  CONSTRUCTEUR ET VALEURS PAR DEFAUT */
  
  General(String _nom){
    super(_nom);
    
    this.setCoefficient();
  }
  
  /*------------------------------------------- SETTERS */
  
  void setCoefficient(){
    this.coefficientX = (valeurMaxX - valeurMinX) / width;
    this.coefficientY = (valeurMaxX - valeurMinX) / height;  
  }
  
  void setRangeX(int _min, int _max){
    this.valeurMinX=_min;
    this.valeurMaxX=_max;
    this.setCoefficient();
  }
  
  void setRangeY(int _min, int _max){
    this.valeurMinY=_min;
    this.valeurMaxY=_max;
    this.setCoefficient();
  }
  
  /*------------------------------------------- FUNCTIONS */
  
  void render(){
    super.render();
        
    this.valeurX = round(this.vecteur.x * coefficientX);
    this.valeurY = round(this.vecteur.y * coefficientY);   
   
    // On relie au master
    stroke(color(0, 0, 0), 30);
    line(this.vecteur.x, this.vecteur.y, width/2, height/2); 
    
    setPdParmX("General", this.nom, valeurX);
    setPdParmY("General", this.nom, valeurY);
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
