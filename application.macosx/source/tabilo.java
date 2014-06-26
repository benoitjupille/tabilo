import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import org.puredata.processing.PureData; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class tabilo extends PApplet {

/*------------------------------------------- LIBRAIRIES */


/*------------------------------------------- OBJETS */
PureData pd;
Master master;
ArrayList<Musicbox> boxes;
ArrayList<Modulo> modulos;
ArrayList<General> generals;

/*------------------------------------------- PROGRAMME */

public void setup() {
  // Pure Data
  pd = new PureData(this, 44100, 0, 2);
  pd.openPatch("tabilo.pd");
  pd.start();
  
  // Graphisme
  size(displayWidth, displayHeight);
  smooth(2);
  frameRate(30);
  
  // Constructeurs Objets
  boxes = new ArrayList<Musicbox>();
  modulos = new ArrayList<Modulo>();
  generals = new ArrayList<General>();
  
  master = new Master();
  master.setPosition(width / 2, height / 2); // On place le Master au centre
  
  /* Generals */
  // General 0 : tempo
  generals.add(new General("Tempo"));
  generals.get(0).initPosition((width/2)-60, height/2);
  generals.get(0).setRangeX(30, 300);
  generals.get(0).setForce(4);
  generals.get(0).setAffichage(35, color(63, 76, 107), color(255, 255, 255), 1);
  
  /* Musicboxes */
  // Musicbox 0 : oscillateur
  boxes.add(new Musicbox("osc1"));
  boxes.get(0).initPosition(width-160, height-160);
  boxes.get(0).setForce(4);
  boxes.get(0).setAffichage(35, color(229, 121, 30), color(229, 121, 30), 8);
  boxes.get(0).satellites.add(new Satellite("Cutoff"));
  boxes.get(0).satellites.add(new Satellite("Delay"));
  boxes.get(0).satellites.get(1).setValeur(0);
  boxes.get(0).satellites.get(1).setCouleur(color(0, 168, 171));

  // modulo1 linkedTo oscillateur 1 : notes
  modulos.add(new Modulo("modulo1"));
  modulos.get(0).autoPosition(boxes.get(0), 1);
  modulos.get(0).setAffichage(35, color(250, 250, 250), color(229, 121, 30), 3);
  modulos.get(0).setLinkedTo(0);
  modulos.get(0).setGrilleNotesX(32);
  
  // modulo2 linkedTo oscillateur 1 : X=decay Y=Attack
  modulos.add(new Modulo("modulo2"));
  modulos.get(1).autoPosition(boxes.get(0), 2);
  modulos.get(1).setAffichage(35, color(250, 250, 250), color(90, 71, 29), 3);
  modulos.get(1).setLinkedTo(0);
  
  
  // Musicbox 1 : oscillateur 2
  boxes.add(new Musicbox("osc2"));
  boxes.get(1).initPosition(width-60, height-160);
  boxes.get(1).setForce(4);
  boxes.get(1).setAffichage(35, color(229, 121, 30), color(229, 121, 30), 8);
  boxes.get(1).satellites.add(new Satellite("Cutoff"));
  boxes.get(1).satellites.add(new Satellite("Delay"));
  boxes.get(1).satellites.get(1).setValeur(0);
  boxes.get(1).satellites.get(1).setCouleur(color(0, 168, 171));
  
  // modulo1 linkedTo oscillateur 2
  modulos.add(new Modulo("modulo1"));
  modulos.get(2).autoPosition(boxes.get(1), 1);
  modulos.get(2).setAffichage(35, color(250, 250, 250), color(229, 121, 30), 2);
  modulos.get(2).setLinkedTo(1);
  modulos.get(2).setGrilleNotesX(32);
  
  // modulo2 linkedTo oscillateur 2 : X=decay Y=Attack
  modulos.add(new Modulo("modulo2"));
  modulos.get(3).autoPosition(boxes.get(1), 2);
  modulos.get(3).setAffichage(35, color(250, 250, 250), color(90, 71, 29), 3);
  modulos.get(3).setLinkedTo(1);
  
  
  // Musicbox 2 : oscillateur 3
  boxes.add(new Musicbox("osc3"));
  boxes.get(2).initPosition(width-160, height-60);
  boxes.get(2).setForce(4);
  boxes.get(2).setAffichage(35, color(229, 121, 30), color(229, 121, 30), 8);
  boxes.get(2).satellites.add(new Satellite("Cutoff"));
  boxes.get(2).satellites.add(new Satellite("Delay"));
  boxes.get(2).satellites.get(1).setValeur(0);
  boxes.get(2).satellites.get(1).setCouleur(color(0, 168, 171));
  
  // modulo1 linkedTo oscillateur 3
  modulos.add(new Modulo("modulo1"));
  modulos.get(4).autoPosition(boxes.get(2), 4);
  modulos.get(4).setAffichage(35, color(250, 250, 250), color(229, 121, 30), 2);
  modulos.get(4).setLinkedTo(2);
  modulos.get(4).setGrilleNotesX(32);
  
  // modulo2 linkedTo oscillateur 2 : X=decay Y=Attack
  modulos.add(new Modulo("modulo2"));
  modulos.get(5).autoPosition(boxes.get(2), 3);
  modulos.get(5).setAffichage(35, color(250, 250, 250), color(90, 71, 29), 3);
  modulos.get(5).setLinkedTo(2);
  
  
  // Musicbox 3 : oscillateur 4
  boxes.add(new Musicbox("osc4"));
  boxes.get(3).initPosition(width-60, height-60);
  boxes.get(3).setForce(4);
  boxes.get(3).setAffichage(35, color(229, 121, 30), color(229, 121, 30), 8);
  boxes.get(3).satellites.add(new Satellite("Cutoff"));
  boxes.get(3).satellites.add(new Satellite("Delay"));
  boxes.get(3).satellites.get(1).setValeur(0);
  boxes.get(3).satellites.get(1).setCouleur(color(0, 168, 171));
  
  // modulo1 linkedTo oscillateur 4
  modulos.add(new Modulo("modulo1"));
  modulos.get(6).autoPosition(boxes.get(3), 4);
  modulos.get(6).setAffichage(35, color(250, 250, 250), color(229, 121, 30), 2);
  modulos.get(6).setLinkedTo(3);
  modulos.get(6).setGrilleNotesX(32);
  
  // modulo2 linkedTo oscillateur 2 : X=decay Y=Attack
  modulos.add(new Modulo("modulo2"));
  modulos.get(7).autoPosition(boxes.get(3), 3);
  modulos.get(7).setAffichage(35, color(250, 250, 250), color(90, 71, 29), 3);
  modulos.get(7).setLinkedTo(3);
  
  // Musicbox
  // Musicbox 4 : kick1
  boxes.add(new Musicbox("kick1"));
  boxes.get(4).initPosition(160, height-160);
  boxes.get(4).setForce(0.5f);
  boxes.get(4).satellites.add(new Satellite("Delay"));
  boxes.get(4).satellites.get(0).setValeur(0);
  boxes.get(4).satellites.get(0).setCouleur(color(0, 168, 171));
  
  // Musicbox 5 : kick2
  boxes.add(new Musicbox("kick2"));
  boxes.get(5).initPosition(60, height-160);
  boxes.get(5).setForce(0.5f);
  boxes.get(5).satellites.add(new Satellite("Delay"));
  boxes.get(5).satellites.get(0).setValeur(0);
  boxes.get(5).satellites.get(0).setCouleur(color(0, 168, 171));
  
  // Musicbox 6 : kick3
  boxes.add(new Musicbox("kick3"));
  boxes.get(6).initPosition(160, height-60);
  boxes.get(6).setForce(0.5f);
  boxes.get(6).satellites.add(new Satellite("Delay"));
  boxes.get(6).satellites.get(0).setValeur(0);
  boxes.get(6).satellites.get(0).setCouleur(color(0, 168, 171));
  
  // Musicbox 7 : kick4
  boxes.add(new Musicbox("kick4"));
  boxes.get(7).initPosition(60, height-60);
  boxes.get(7).setForce(0.5f);
  boxes.get(7).satellites.add(new Satellite("Delay"));
  boxes.get(7).satellites.get(0).setValeur(0);
  boxes.get(7).satellites.get(0).setCouleur(color(0, 168, 171));
  
  // Musicbox 8 : perc1
  boxes.add(new Musicbox("perc1"));
  boxes.get(8).initPosition(160, 160);
  boxes.get(8).setForce(7);
  boxes.get(8).setAffichage(35, color(76, 184, 72), color(0, 114, 45), 8);
  boxes.get(8).satellites.add(new Satellite("Cutoff"));
  boxes.get(8).satellites.get(0).setValeur(127);
  boxes.get(8).satellites.add(new Satellite("Delay"));
  boxes.get(8).satellites.get(1).setValeur(0);
  boxes.get(8).satellites.get(1).setCouleur(color(0, 168, 171));
  
  // modulo1 linkedTo perc 1
  modulos.add(new Modulo("modulo1"));
  modulos.get(8).autoPosition(boxes.get(8), 3);
  modulos.get(8).setAffichage(35, color(250, 250, 250), color(76, 184, 72), 2);
  modulos.get(8).setLinkedTo(8);
  
  // Musicbox 9 : perc2
  boxes.add(new Musicbox("perc2"));
  boxes.get(9).initPosition(60, 160);
  boxes.get(9).setForce(7);
  boxes.get(9).setAffichage(35, color(76, 184, 72), color(0, 114, 45), 8);
  boxes.get(9).satellites.add(new Satellite("Cutoff"));
  boxes.get(9).satellites.get(0).setValeur(127);
  boxes.get(9).satellites.add(new Satellite("Delay"));
  boxes.get(9).satellites.get(1).setValeur(0);
  boxes.get(9).satellites.get(1).setCouleur(color(0, 168, 171));
  
  // modulo1 linkedTo perc 2
  modulos.add(new Modulo("modulo1"));
  modulos.get(9).autoPosition(boxes.get(9), 4);
  modulos.get(9).setAffichage(35, color(250, 250, 250), color(76, 184, 72), 2);
  modulos.get(9).setLinkedTo(9);
  
  // Musicbox 10 : perc3
  boxes.add(new Musicbox("perc3"));
  boxes.get(10).initPosition(160, 60);
  boxes.get(10).setForce(7);
  boxes.get(10).setAffichage(35, color(76, 184, 72), color(0, 114, 45), 8);
  boxes.get(10).satellites.add(new Satellite("Cutoff"));
  boxes.get(10).satellites.get(0).setValeur(127);
  boxes.get(10).satellites.add(new Satellite("Delay"));
  boxes.get(10).satellites.get(1).setValeur(0);
  boxes.get(10).satellites.get(1).setCouleur(color(0, 168, 171));
  
  // modulo1 linkedTo perc 3
  modulos.add(new Modulo("modulo1"));
  modulos.get(10).autoPosition(boxes.get(10), 2);
  modulos.get(10).setAffichage(35, color(250, 250, 250), color(76, 184, 72), 2);
  modulos.get(10).setLinkedTo(10);
  
  // Musicbox 11 : perc4
  boxes.add(new Musicbox("perc4"));
  boxes.get(11).initPosition(60, 60);
  boxes.get(11).setForce(7);
  boxes.get(11).setAffichage(35, color(76, 184, 72), color(0, 114, 45), 8);
  boxes.get(11).satellites.add(new Satellite("Cutoff"));
  boxes.get(11).satellites.get(0).setValeur(127);
  boxes.get(11).satellites.add(new Satellite("Delay"));
  boxes.get(11).satellites.get(1).setValeur(0);
  boxes.get(11).satellites.get(1).setCouleur(color(0, 168, 171));
  
  // modulo1 linkedTo perc 4
  modulos.add(new Modulo("modulo1"));
  modulos.get(11).autoPosition(boxes.get(11), 1);
  modulos.get(11).setAffichage(35, color(250, 250, 250), color(76, 184, 72), 2);
  modulos.get(11).setLinkedTo(11);
  
  // Musicbox 12 : perc5
  boxes.add(new Musicbox("perc5"));
  boxes.get(12).initPosition(width-160, 60);
  boxes.get(12).setForce(7);
  boxes.get(12).setAffichage(35, color(136, 136, 136), color(136, 136, 136), 8);
  boxes.get(12).satellites.add(new Satellite("Cutoff"));
  boxes.get(12).satellites.get(0).setValeur(127);
  boxes.get(12).satellites.add(new Satellite("Delay"));
  boxes.get(12).satellites.get(1).setValeur(0);
  boxes.get(12).satellites.get(1).setCouleur(color(0, 168, 171));
  
  // modulo1 linkedTo perc 4
  modulos.add(new Modulo("modulo1"));
  modulos.get(12).autoPosition(boxes.get(12), 4);
  modulos.get(12).setAffichage(35, color(250, 250, 250), color(136, 136, 136), 2);
  modulos.get(12).setLinkedTo(12);
  
  // Musicbox 13 : perc6
  boxes.add(new Musicbox("perc6"));
  boxes.get(13).initPosition(width-60, 60);
  boxes.get(13).setForce(7);
  boxes.get(13).setAffichage(35, color(136, 136, 136), color(136, 136, 136), 8);
  boxes.get(13).satellites.add(new Satellite("Cutoff"));
  boxes.get(13).satellites.get(0).setValeur(127);
  boxes.get(13).satellites.add(new Satellite("Delay"));
  boxes.get(13).satellites.get(1).setValeur(0);
  boxes.get(13).satellites.get(1).setCouleur(color(0, 168, 171));
  
  // modulo1 linkedTo perc 6
  modulos.add(new Modulo("modulo1"));
  modulos.get(13).autoPosition(boxes.get(13), 3);
  modulos.get(13).setAffichage(35, color(250, 250, 250), color(136, 136, 136), 2);
  modulos.get(13).setLinkedTo(13);
}

public void draw(){
  background(255);
  
  master.render();
  
  Musicbox box;
  Modulo mod;
  General general;
  
  for(int i=0; i<boxes.size(); i++){
    box = boxes.get(i);
    box.ralentit();
    box.render();
    box.setVolume(master.vecteur);
  }
  
  for(int i=0; i<modulos.size(); i++){
    mod = modulos.get(i);
    mod.ralentit();
    mod.render(boxes.get(mod.linkedTo));
  }
  
  for(int i=0; i<generals.size(); i++){
    general = generals.get(i);
    general.ralentit();
    general.render();
  }
}

/*------------------------------------------- FUNCTIONS */

public void mousePressed(){
  Musicbox box;
  Modulo mod;
  General general;
  Satellite sat;
  int oneIsLocked = 0;
  
  for(int i=0; i<boxes.size(); i++){
    box = boxes.get(i);
    if(box.over() && oneIsLocked == 0){
      box.locked = true;
      box.resetvitesse();
      oneIsLocked = 1;
    }else{
      for(int j=0; j<box.satellites.size(); j++){
        sat = box.satellites.get(j);
        if(sat.overSatellite()){
          sat.locked = true;
        }
      }
    }
  }
  
  for(int i=0; i<modulos.size(); i++){
    mod = modulos.get(i);
    if(mod.over() && oneIsLocked == 0){
      mod.resetvitesse();
      mod.locked = true;
      oneIsLocked = 1;
    }
  }
  
  for(int i=0; i<generals.size(); i++){
    general = generals.get(i);
    if(general.over() && oneIsLocked == 0){
      general.resetvitesse();
      general.locked = true;
      oneIsLocked = 1;
    }
  }
}

public void mouseDragged(){
  Musicbox box;
  Modulo mod;
  General general;
  Satellite sat;
  
  for(int i=0; i<boxes.size(); i++){
    box = boxes.get(i);
    if(box.locked){
      box.calculeVitesse(mouseX, mouseY);
      box.setPosition(mouseX, mouseY);
    }else{
      for(int k=0; k<box.satellites.size(); k++){
        sat = box.satellites.get(k);
        if(sat.locked){
          sat.setValeurParPosition();
          if(sat.nom=="Delay"){
            sat.midiToMs(generals.get(0).valeurX);
          }
        }
      }
    }
  }
  
  for(int i=0; i<modulos.size(); i++){
    mod = modulos.get(i);
    if(mod.locked){
      mod.calculeVitesse(mouseX, mouseY);
      mod.setPosition(mouseX, mouseY);
    }
  }
  
  for(int i=0; i<generals.size(); i++){
    general = generals.get(i);
    if(general.locked){
      general.calculeVitesse(mouseX, mouseY);
      general.setPosition(mouseX, mouseY);
    }
  }
}

public void mouseReleased(){
  Musicbox box;
  Modulo mod;
  General general;
  Satellite sat;
  
  for(int i=0; i<boxes.size(); i++){
    box = boxes.get(i);
    box.calculeCible(mouseX, mouseY);
    box.locked = false;
    for(int j=0; j<box.satellites.size(); j++){
      sat = box.satellites.get(j);
      sat.locked = false;
    }
  }
  
  for(int i=0; i<modulos.size(); i++){
    mod = modulos.get(i);
    mod.calculeCible(mouseX, mouseY);
    mod.locked = false;
  }
  
  for(int i=0; i<generals.size(); i++){
    general = generals.get(i);
    general.calculeCible(mouseX, mouseY);
    general.locked = false;
  }
}

public boolean sketchFullScreen() {
  return true;
}

/* Les General permettent de d\u00e9finir les propri\u00e9t\u00e9s g\u00e9n\u00e9rales d'un morceau : tempo, etc... */
class General extends Musicbox{
  
  /*-------------------------------------------  VARIABLES */
              
  int valeurX;
  int valeurY;
  
  float valeurMaxX = 280.0f;
  float valeurMinX = 60.0f;
  float valeurMaxY = 280.0f;
  float valeurMinY = 60.0f;
  float coefficientX;
  float coefficientY;
  
  /*-------------------------------------------  CONSTRUCTEUR ET VALEURS PAR DEFAUT */
  
  General(String _nom){
    super(_nom);
    
    this.setCoefficient();
  }
  
  /*------------------------------------------- SETTERS */
  
  public void setCoefficient(){
    this.coefficientX = (valeurMaxX - valeurMinX) / width;
    this.coefficientY = (valeurMaxX - valeurMinX) / height;  
  }
  
  public void setRangeX(int _min, int _max){
    this.valeurMinX=_min;
    this.valeurMaxX=_max;
    this.setCoefficient();
  }
  
  public void setRangeY(int _min, int _max){
    this.valeurMinY=_min;
    this.valeurMaxY=_max;
    this.setCoefficient();
  }
  
  /*------------------------------------------- FUNCTIONS */
  
  public void render(){
    super.render();
        
    this.valeurX = round(this.vecteur.x * coefficientX);
    this.valeurY = round(this.vecteur.y * coefficientY);   
   
    // On relie au master
    stroke(color(0, 0, 0), 30);
    line(this.vecteur.x, this.vecteur.y, width/2, height/2); 
    
    setPdParmX("General", this.nom, valeurX);
    setPdParmY("General", this.nom, valeurY);
  }
  
  public void setPdParmX(String _nomObjet, String _nomParametre, int _valeur){
    String nomEtParametre = _nomObjet + _nomParametre + "X";
    pd.sendFloat(nomEtParametre, _valeur);
  }
  
  public void setPdParmY(String _nomObjet, String _nomParametre, int _valeur){
    String nomEtParametre = _nomObjet + _nomParametre + "Y";
    pd.sendFloat(nomEtParametre, _valeur);
  }
}
/**************** CLASS MASTER ****************/
/* Element au centre qui ne bouge pas. Plus on approche une Musicbox de lui, 
et plus le volume de cette Musicbox sera \u00e9lev\u00e9 */

class Master{
  
  /*-------------------------------------------  VARIABLES */
  PVector vecteur; // On utilise un objet de la classe PVector, pour b\u00e9n\u00e9ficier des variables de position et des fonctions comme dist(vecteur1, vecteur2)
  float diametre; // Diametre du rond qui repr\u00e9sente l'objet graphiquement
  int couleur; // Couleur de remplissage du rond 
  float epaisseurStroke; // Epaisseur de la bordure autour du rond
  int couleurStroke; // Couleur de la bordure autour du rond
 
  float wobbling; // rapidit\u00e9 de l'effet vibration
  int wobbleWay; // 0 = gonfle; 1 = d\u00e9gonfle
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
  
  public void setPosition(float _x, float _y){
    this.vecteur.set(_x, _y, 0);
  }   
  
  /*------------------------------------------- FUNCTIONS */
  
  // dessine le cercle
  public void render(){
    fill(this.couleur);
    stroke(this.couleurStroke, 100);
    strokeWeight(this.epaisseurStroke);
    ellipse(this.vecteur.x, this.vecteur.y, this.diametre, this.diametre);
    this.wobble();
  }
  
  // Fait vibrer le cercle sur lui m\u00eame
  public void wobble(){
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
/* Les modulo sont les \u00e9l\u00e9ments rattach\u00e9s \u00e0 une Musicbox. Ils permettent de r\u00e9gler des param\u00e8tres (note, decay, attack...) */
class Modulo extends Musicbox{
  
  /*-------------------------------------------  VARIABLES */
  
  int linkedTo; // Le linkedTo permet de dire que cet objet est li\u00e9 \u00e0 un autre objet 
                // Le linkedTo est un int qui prend l'id d'un objet de la collection <Array>boxes 
              
  int valeurX;
  int valeurY;
  
  float valeurMax = 127.0f;
  float coefficientX;
  float coefficientY;
  int force=12;
  
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
  
  public void setLinkedTo(int _id){
    this.linkedTo = _id;
  }
  
  public void setGrilleNotesX(int _nombreDeNotes){
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
  
  // Place automatiquement le modulo en fonction des coordonn\u00e9es de la box \u00e0 laquelle il est rattach\u00e9. 
  // _box : box rattach\u00e9e
  // place : si c'est le premier ou deuxi\u00e8me modulo de la box en question(ou troisi\u00e8me etc)
  public void autoPosition(Musicbox _box, int _place){
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
  
  public void render(Musicbox _musicbox){
    super.render();
    strokeWeight(1);
    stroke(0, 50);
    line(this.vecteur.x, this.vecteur.y, _musicbox.vecteur.x, _musicbox.vecteur.y);
    
    this.valeurX = round(this.vecteur.x * coefficientX);
    this.valeurY = round(this.vecteur.y * coefficientY);
    
    if(this.grilleX){
      this.valeurX = this.grilleValeurX[this.valeurX];
    }else{
      this.valeurX = this.valeurX * this.force;
    }
    
    setPdParmX(_musicbox.nom, this.nom, valeurX);
    setPdParmY(_musicbox.nom, this.nom, valeurY);
  }
  
  public void setPdParmX(String _nomObjet, String _nomParametre, int _valeur){
    String nomEtParametre = _nomObjet + _nomParametre + "X";
    pd.sendFloat(nomEtParametre, _valeur);
  }
  
  public void setPdParmY(String _nomObjet, String _nomParametre, int _valeur){
    String nomEtParametre = _nomObjet + _nomParametre + "Y";
    pd.sendFloat(nomEtParametre, _valeur);
  }
}
/**************** CLASS MUSICBOX ****************/
/* Une Musicbox est un \u00e9l\u00e9ment auquel on attribue un son dans Pure Data 
 Ils peuvent \u00eatre un oscillateur ou un sampler */

class Musicbox{
  
  /*-------------------------------------------  VARIABLES */
  
  ArrayList<Satellite> satellites; // Les satellites sont des param\u00e8tres (cutoff, release,...) d'une Musicbox. 
                                   // Ils sont repr\u00e9sent\u00e9s par des ronds plut petits.
  float diametreCeinture; // Un satellite se position sur une ceinture autour d'une Musicbox
                 
  String nom; // Nom de la Musicbox [important] \u00e0 renseigner absolument pour que Pure Data sache de quel \u00e9l\u00e9ment il s'agit
  float force; // C'est la courbe de progression du volume quand on s'approche du Master au centre
  float volume; // Le volume de l'objet, envoy\u00e9 \u00e0 Pure Data
  float distance; // Distance entre l'objet et le Master
  boolean locked; // Si on a positionn\u00e9 le curseur sur l'objet et que l'on a la souris "pressed"

  // Variables pour l'affichage
  PVector vecteur; // On utilise un objet de la classe PVector, pour b\u00e9n\u00e9ficier des variables de position et des fonctions comme dist(vecteur1, vecteur2)
  float diametre; // Diametre du rond qui repr\u00e9sente l'objet graphiquement
  int couleur; // Couleur de remplissage du rond
  float epaisseurStroke; // Epaisseur de la bordure autour du rond
  int couleurStroke; // Couleur de la bordure autour du rond

  float rayon; // diametre / 2
  
  // Variables pour la physique : quand on donne de l'\u00e9lan \u00e0 un \u00e9l\u00e9ment
  float vitesseX; // \u00e9lan X
  float vitesseY; // \u00e9lan Y
  float cibleX; // coordonn\u00e9e x o\u00f9 l'\u00e9l\u00e9ment va se rendre avec l'\u00e9lan qu'on lui a donn\u00e9
  float cibleY; // coordonn\u00e9e y o\u00f9 l'\u00e9l\u00e9ment va se rendre avec l'\u00e9lan qu'on lui a donn\u00e9
  float velocite=0.9f; // Vitesse de ralentissement
  float vitesseFinale=0; // Vitesse de l'\u00e9l\u00e9ment sans \u00e9lan
  float vitesseMinimum=4; // \u00e9lan minimum pour que ce soit pris en compte
 
 
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
  public void ajustements(){
    this.rayon = this.diametre / 2;
    this.diametreCeinture = this.diametre + this.epaisseurStroke + 50;
  }
  
  // Param\u00e8tres graphiques
  public void setAffichage(float _diametre, int _couleurRemplissage, int _couleurContour, float _epaisseurContour){
    this.diametre = _diametre;
    this.rayon = this.diametre / 2;
    this.couleur = _couleurRemplissage;
    this.couleurStroke = _couleurContour;
    this.epaisseurStroke = _epaisseurContour;
    this.ajustements();
  }
  
  public void setForce(float _force){
    this.force = _force;
  }
  
  /*------------------------------------------- FUNCTIONS */
  
  // Affichage GUI
  public void render(){
    strokeWeight(this.epaisseurStroke);
    stroke(this.couleurStroke, 180);
    fill(this.couleur,180);
    ellipse(this.vecteur.x, this.vecteur.y, this.diametre, this.diametre);
    
    this.renderSatellites(); 
  }
  
  public void initPosition(float _x, float _y){
    this.vecteur.x = (_x);
    this.vecteur.y = (_y);
  }   
  
  public void setPosition(float _x, float _y){
    this.vecteur.x = constrain(_x, 0+this.rayon+this.epaisseurStroke, width-this.rayon-this.epaisseurStroke);
    this.vecteur.y = constrain(_y, 0+this.rayon+this.epaisseurStroke, height-this.rayon-this.epaisseurStroke);
  }   
  
  // Calcule le volume per\u00e7u et envoie la valeur au patch Pure Data
  public void setVolume(PVector _vecteurMaster){
    this.distance = this.vecteur.dist(this.vecteur, _vecteurMaster);
    this.volume = (this.distance / (width / 2.5f)) * (-1) + 1;
    this.volume = this.volume / this.force;
    
    if(this.volume < 0){
      this.volume = 0;
    }
  
    this.setPdParm(this.nom, "Volume", this.volume);
  }
  
  public void collisionEcran(){
    // X
    if((this.vecteur.x + this.rayon + this.epaisseurStroke - width==0) || (this.vecteur.x - this.rayon - this.epaisseurStroke==0)){
      this.vitesseX*=-1;
    }
    
    // Y
    if((this.vecteur.y + this.rayon + this.epaisseurStroke - height==0) || (this.vecteur.y - this.rayon - this.epaisseurStroke==0)){
      this.vitesseY*=-1;
    }
  }
  
  // Envoie les valeurs \u00e0 Pure Data.
  // Le param\u00e8tre se compose du nom de l'objet, du nom du param\u00e8tre, de sa valeur
  // Ensuite, on forme un String avec le nom de l'objet et du param\u00e8tre
  // Ex : oscillateur, Cutoff, 36
  // -> devient oscillateurCutoff
  // Pour ensuite \u00eatre transmis \u00e0 une variable du m\u00eame nom dans Pure Data
  public void setPdParm(String _nomObjet, String _nomParametre, float _valeur){
    String nomEtParametre = _nomObjet + _nomParametre;
    pd.sendFloat(nomEtParametre, _valeur);
  }
  
  // Calcul l'\u00e9lan que l'on donne avec le mouvement de souris
  public void calculeVitesse(float _x, float _y){
    this.vitesseX = _x - this.vecteur.x;
    this.vitesseY = _y - this.vecteur.y;
    if(abs(this.vitesseX) < vitesseMinimum){
      this.vitesseX = this.vitesseFinale;
    }
    if(abs(this.vitesseY) < vitesseMinimum){
      this.vitesseY = this.vitesseFinale;
    }
  }
  
  // Calcule jusqu'o\u00f9 le point devrait se rendre gr\u00e2ce \u00e0 l'\u00e9lan
  public void calculeCible(float _x, float _y){
    if(this.locked){
      this.cibleX = _x + this.vitesseX;
      this.cibleY = _y + this.vitesseY;
    }
  }
  
  // L'\u00e9l\u00e9ment se d\u00e9place gr\u00e2ce \u00e0 l'\u00e9lan mais perd en vitesse
  public void ralentit(){
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
  
  // Reset de l'\u00e9lan \u00e0 0
  public void resetvitesse(){
    this.vitesseX = this.vitesseFinale;
    this.vitesseY = this.vitesseFinale;
  }
  
  // Affichage GUI des satellites
  public void renderSatellites(){
    // On affiche les satellites si on est au dessus des ceintures OU si un des satellites est locked
    // (ce qui veut dire que l'utilisateur est en train de Dragger la souris pour d\u00e9placer un satellite)
    if(this.overCeinture() || this.satelliteLocked()){
      
      Satellite sat;  
      
      for(int i=0; i<this.satellites.size(); i++){
        sat = this.satellites.get(i);
        sat.render(this.vecteur, this.diametreCeinture * (i+1), i); // Chaque nouveau param\u00e8tre est dessin\u00e9 sur une ceinture plus grande
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
  public boolean over() {
    if(dist(mouseX, mouseY, this.vecteur.x, this.vecteur.y) - this.rayon <= 0){
      return true;
    }else{
      return false;
    }
  }
  
  // Retourne true si la souris se trouve sur la zone Ceinture
  public boolean overCeinture() {
    if(dist(mouseX, mouseY, this.vecteur.x, this.vecteur.y) - this.diametreCeinture - 10 <= 0){
      return true;
    }else{
      return false;
    }
  }
  
  // On teste si au moins 1 des satellites est utilis\u00e9
  public boolean satelliteLocked(){
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

/**************** CLASS SATELLITE ****************/
/* Les satellites sont des param\u00e8tres (cutoff, release,...) d'une Musicbox. 
Ils sont repr\u00e9sent\u00e9s par des ronds plut petits. */

class Satellite{
  
  /*-------------------------------------------  VARIABLES */
  float valeur; // Valeur du param\u00e8tre
  float valeurMs; // Valeur du param\u00e8tre en milliseconds. Il prend le dessus sur "valeur" s'il est > 0
  String nom; // Nom du param\u00e8tre [important] \u00e0 renseigner absolument pour que Pure Data sache de quel \u00e9l\u00e9ment il s'agit
  boolean locked; // Si on a positionn\u00e9 le curseur sur l'objet et que l'on a la souris "pressed" => donc que le param\u00e8tre est en train d'\u00eatre modifi\u00e9
  PVector vecteur; // On utilise un objet de la classe PVector, pour b\u00e9n\u00e9ficier des variables de position et des fonctions comme dist(vecteur1, vecteur2)
  float diametre; // Diametre du rond qui repr\u00e9sente l'objet graphiquement
  int couleur; // Couleur du rond 
  float rayon; 
  float angleDepart; // D\u00e9part de l'arc de cercle
  float angleFin; // Fin de l'arc de cercle. On utilise de 0 \u00e0 127, puisque les valeurs envoy\u00e9es \u00e0 Pure Data vont de 0 \u00e0 127
    
    
  /*-------------------------------------------  CONSTRUCTEUR ET VALEURS PAR DEFAUT */
  Satellite(String _nom){
    this.nom = _nom;
    this.locked = false;
    this.valeur = 80;
    this.valeurMs=0;
    
    this.vecteur = new PVector();
    this.couleur = color(168, 26, 26);
    this.diametre = 40;
    this.rayon = this.diametre / 2;
    
    this.angleDepart = 0;
    this.angleFin = 127;
  }
  
  /*------------------------------------------- SETTERS */
  
  public void setCouleur(int _color){
    this.couleur = _color;
  }
  
  public void setValeur(float _valeur){
    this.valeur = _valeur;
  }
  
  // Renseigne la position du satellite sur sa ceinture, en fonction de sa valeur, de la position de la box et du diam\u00e8tre de la ceinture
  public void setPosition(PVector _vecteurMusicbox, float _diametre){
    this.vecteur.x = cos(radians(this.valeur)) * (_diametre / 2);
    this.vecteur.y = sin(radians(this.valeur)) * (_diametre / 2);
    
    // Maintenant on ajoute la position de la box
    this.vecteur.x = this.vecteur.x + _vecteurMusicbox.x;
    this.vecteur.y = this.vecteur.y + _vecteurMusicbox.y;
  }
  
  // On renseigne la valeur du satellite par les mouvements de la souris
  // C'est ensuite la fonction setPosition(...), appel\u00e9e dans render(...) qui se chargera de calculer les coordonn\u00e9es
  public void setValeurParPosition(){
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
  }
  
  /*------------------------------------------- FUNCTIONS */ 
  
  // Affichage GUI
  public void render(PVector _vecteurMusicbox, float _diametreCeinture, float _id){   
    // Dessine la ceinture
    fill(250, 250, 250, 0);
    strokeWeight(1);
    stroke(0, 50);
    arc(_vecteurMusicbox.x, _vecteurMusicbox.y, _diametreCeinture, _diametreCeinture, radians(angleDepart), radians(angleFin), OPEN);
    
    // Positionne le param\u00e8tre sur la ceinture en fonction de sa valeur
    this.setPosition(_vecteurMusicbox, _diametreCeinture);
    
    // Dessine le rond qui repr\u00e9sente le param\u00e8tre
    noStroke();
    fill(this.couleur,180);
    ellipse(this.vecteur.x, this.vecteur.y, this.diametre, this.diametre);
  }
  
  public void midiToMs(int _tempo){
    float pourcentage=(this.valeur/127)*100;
    this.valeurMs=(pourcentage*(60000/_tempo))/100;
  }
  
  /*------------------------------------------- BOOLEENS */
  
  // Retourne true si la souris se trouve sur le satellite
  public boolean overSatellite() {
    if(dist(mouseX, mouseY, this.vecteur.x, this.vecteur.y) - this.rayon <= 0){
      return true;
    }else{
      return false;
    }
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--hide-stop", "tabilo" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
