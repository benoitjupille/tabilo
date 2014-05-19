/*------------------------------------------- LIBRAIRIES */
import org.puredata.processing.PureData;

/*------------------------------------------- OBJETS */
PureData pd;
Master master;
ArrayList<Musicbox> boxes;
ArrayList<Modulo> modulos;

/*------------------------------------------- PROGRAMME */

void setup() {
  // Pure Data
  pd = new PureData(this, 44100, 0, 2);
  pd.openPatch("tabilo.pd");
  pd.start();
  
  // Graphisme
  size(displayWidth - 30, displayHeight - 60);
  smooth(2);
  frameRate(30);
  
  // Constructeurs Objets
  boxes = new ArrayList<Musicbox>();
  
  modulos = new ArrayList<Modulo>();
  
  master = new Master();
  master.setPosition(width / 2, height / 2); // On place le Master au centre
  
 
  
  // Musicbox 0 : oscillateur
  boxes.add(new Musicbox("osc1"));
  boxes.get(0).initPosition(270, 270);
  boxes.get(0).setForce(4);
  boxes.get(0).setAffichage(35, color(229, 121, 30), color(229, 121, 30), 8);
  boxes.get(0).satellites.add(new Satellite("Cutoff"));
  boxes.get(0).satellites.add(new Satellite("Delay"));
  boxes.get(0).satellites.get(1).setValeur(0);
  boxes.get(0).satellites.get(1).setCouleur(color(0, 168, 171));

  // modulo1 linkedTo oscillateur 1 : notes
  modulos.add(new Modulo("modulo1"));
  modulos.get(0).initPosition(350, 400);
  modulos.get(0).setAffichage(35, color(250, 250, 250), color(229, 121, 30), 3);
  modulos.get(0).setLinkedTo(0);
  modulos.get(0).setGrilleNotesX(32);
  
  // modulo2 linkedTo oscillateur 1 : X=decay Y=Attack
  modulos.add(new Modulo("modulo2"));
  modulos.get(1).initPosition(310, 400);
  modulos.get(1).setAffichage(35, color(250, 250, 250), color(90, 71, 29), 3);
  modulos.get(1).setLinkedTo(0);
  
  
  // Musicbox 1 : oscillateur 2
  boxes.add(new Musicbox("osc2"));
  boxes.get(1).initPosition(190, 270);
  boxes.get(1).setForce(4);
  boxes.get(1).setAffichage(35, color(229, 121, 30), color(229, 121, 30), 8);
  boxes.get(1).satellites.add(new Satellite("Cutoff"));
  boxes.get(1).satellites.add(new Satellite("Delay"));
  boxes.get(1).satellites.get(1).setValeur(0);
  boxes.get(1).satellites.get(1).setCouleur(color(0, 168, 171));
  
  // modulo1 linkedTo oscillateur 2
  modulos.add(new Modulo("modulo1"));
  modulos.get(2).initPosition(270, 400);
  modulos.get(2).setAffichage(35, color(250, 250, 250), color(229, 121, 30), 2);
  modulos.get(2).setLinkedTo(1);
  modulos.get(2).setGrilleNotesX(32);
  
  // modulo2 linkedTo oscillateur 2 : X=decay Y=Attack
  modulos.add(new Modulo("modulo2"));
  modulos.get(3).initPosition(230, 400);
  modulos.get(3).setAffichage(35, color(250, 250, 250), color(90, 71, 29), 3);
  modulos.get(3).setLinkedTo(1);
  
  
  // Musicbox 2 : oscillateur 3
  boxes.add(new Musicbox("osc3"));
  boxes.get(2).initPosition(110, 270);
  boxes.get(2).setForce(4);
  boxes.get(2).setAffichage(35, color(229, 121, 30), color(229, 121, 30), 8);
  boxes.get(2).satellites.add(new Satellite("Cutoff"));
  boxes.get(2).satellites.add(new Satellite("Delay"));
  boxes.get(2).satellites.get(1).setValeur(0);
  boxes.get(2).satellites.get(1).setCouleur(color(0, 168, 171));
  
  // modulo1 linkedTo oscillateur 3
  modulos.add(new Modulo("modulo1"));
  modulos.get(4).initPosition(190, 400);
  modulos.get(4).setAffichage(35, color(250, 250, 250), color(229, 121, 30), 2);
  modulos.get(4).setLinkedTo(2);
  modulos.get(4).setGrilleNotesX(32);
  
  // modulo2 linkedTo oscillateur 2 : X=decay Y=Attack
  modulos.add(new Modulo("modulo2"));
  modulos.get(5).initPosition(150, 400);
  modulos.get(5).setAffichage(35, color(250, 250, 250), color(90, 71, 29), 3);
  modulos.get(5).setLinkedTo(2);
  
  
  // Musicbox 3 : oscillateur 4
  boxes.add(new Musicbox("osc4"));
  boxes.get(3).initPosition(30, 270);
  boxes.get(3).setForce(4);
  boxes.get(3).setAffichage(35, color(229, 121, 30), color(229, 121, 30), 8);
  boxes.get(3).satellites.add(new Satellite("Cutoff"));
  boxes.get(3).satellites.add(new Satellite("Delay"));
  boxes.get(3).satellites.get(1).setValeur(0);
  boxes.get(3).satellites.get(1).setCouleur(color(0, 168, 171));
  
  // modulo1 linkedTo oscillateur 3
  modulos.add(new Modulo("modulo1"));
  modulos.get(6).initPosition(110, 400);
  modulos.get(6).setAffichage(35, color(250, 250, 250), color(229, 121, 30), 2);
  modulos.get(6).setLinkedTo(3);
  modulos.get(6).setGrilleNotesX(32);
  
  // modulo2 linkedTo oscillateur 2 : X=decay Y=Attack
  modulos.add(new Modulo("modulo2"));
  modulos.get(7).initPosition(70, 400);
  modulos.get(7).setAffichage(35, color(250, 250, 250), color(90, 71, 29), 3);
  modulos.get(7).setLinkedTo(3);
  
  // Musicbox
  // Musicbox 4 : kick1
  boxes.add(new Musicbox("kick1"));
  boxes.get(4).initPosition(270, 30);
  boxes.get(4).setForce(1);
  boxes.get(4).satellites.add(new Satellite("Delay"));
  boxes.get(4).satellites.get(0).setValeur(0);
  boxes.get(4).satellites.get(0).setCouleur(color(0, 168, 171));
  
  // Musicbox 5 : kick2
  boxes.add(new Musicbox("kick2"));
  boxes.get(5).initPosition(190, 30);
  boxes.get(5).setForce(1);
  boxes.get(5).satellites.add(new Satellite("Delay"));
  boxes.get(5).satellites.get(0).setValeur(0);
  boxes.get(5).satellites.get(0).setCouleur(color(0, 168, 171));
  
  // Musicbox 6 : kick3
  boxes.add(new Musicbox("kick3"));
  boxes.get(6).initPosition(110, 30);
  boxes.get(6).setForce(1);
  boxes.get(6).satellites.add(new Satellite("Delay"));
  boxes.get(6).satellites.get(0).setValeur(0);
  boxes.get(6).satellites.get(0).setCouleur(color(0, 168, 171));
  
  // Musicbox 7 : kick4
  boxes.add(new Musicbox("kick4"));
  boxes.get(7).initPosition(30, 30);
  boxes.get(7).setForce(1);
  boxes.get(7).satellites.add(new Satellite("Delay"));
  boxes.get(7).satellites.get(0).setValeur(0);
  boxes.get(7).satellites.get(0).setCouleur(color(0, 168, 171));
  
  // Musicbox 8 : snare1
  boxes.add(new Musicbox("snare1"));
  boxes.get(8).initPosition(270, 150);
  boxes.get(8).setForce(7);
  boxes.get(8).setAffichage(35, color(76, 184, 72), color(0, 114, 45), 8);
  boxes.get(8).satellites.add(new Satellite("Delay"));
  boxes.get(8).satellites.get(0).setValeur(0);
  boxes.get(8).satellites.get(0).setCouleur(color(0, 168, 171));
  
  // Musicbox 9 : snare2
  boxes.add(new Musicbox("snare2"));
  boxes.get(9).initPosition(190, 150);
  boxes.get(9).setForce(7);
  boxes.get(9).setAffichage(35, color(76, 184, 72), color(0, 114, 45), 8);
  boxes.get(9).satellites.add(new Satellite("Delay"));
  boxes.get(9).satellites.get(0).setValeur(0);
  boxes.get(9).satellites.get(0).setCouleur(color(0, 168, 171));
}

void draw(){
  background(255);
  
  master.render();
  
  Musicbox box;
  Modulo mod;
  
  for(int i=0; i<boxes.size(); i++){
    box = boxes.get(i);
    box.render();
    box.setVolume(master.vecteur);
  }
  
  for(int j=0; j<modulos.size(); j++){
    mod = modulos.get(j);
    mod.render(boxes.get(mod.linkedTo));
  }
}

/*------------------------------------------- FUNCTIONS */

void mousePressed(){
  Musicbox box;
  Modulo mod;
  Satellite sat;
  int oneIsLocked = 0;
  
  for(int i=0; i<boxes.size(); i++){
    box = boxes.get(i);
    if(box.over() && oneIsLocked == 0){
      box.locked = true;
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
  
  for(int k=0; k<modulos.size(); k++){
    mod = modulos.get(k);
    if(mod.over() && oneIsLocked == 0){
      mod.locked = true;
      oneIsLocked = 1;
    }
  }
}

void mouseDragged(){
  Musicbox box;
  Modulo mod;
  Satellite sat;
  
  for(int i=0; i<boxes.size(); i++){
    box = boxes.get(i);
    if(box.locked){
      box.setPosition(mouseX, mouseY);
    }else{
      for(int k=0; k<box.satellites.size(); k++){
        sat = box.satellites.get(k);
        if(sat.locked){
          sat.setValeurParPosition();
        }
      }
    }
  }
  
  for(int k=0; k<modulos.size(); k++){
    mod = modulos.get(k);
    if(mod.locked){
      mod.setPosition(mouseX, mouseY);
    }
  }
}

void mouseReleased(){
  Musicbox box;
  Modulo mod;
  Satellite sat;
  
  for(int i=0; i<boxes.size(); i++){
    box = boxes.get(i);
    box.locked = false;
    for(int j=0; j<box.satellites.size(); j++){
      sat = box.satellites.get(j);
      sat.locked = false;
    }
  }
  
  for(int k=0; k<modulos.size(); k++){
    mod = modulos.get(k);
    mod.locked = false;
  }
}


